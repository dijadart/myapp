// lib/features/interview/presentation/pages/register_interview_page.dart

import 'dart:math' as math;

import 'package:advanced_2/features/interview/data/models/branchmodel.dart';
import 'package:advanced_2/features/interview/data/models/interviewrequestmodel.dart';
import 'package:advanced_2/features/interview/data/providers/interview_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterInterviewPage extends ConsumerStatefulWidget {
  const RegisterInterviewPage({super.key});

  @override
  ConsumerState<RegisterInterviewPage> createState() =>
      _RegisterInterviewPageState();
}

class _RegisterInterviewPageState
    extends ConsumerState<RegisterInterviewPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();

  DateTime? _dateOfBirth;

  String? _selectedInterviewDay;
  String? _selectedInterviewTime;
  BranchModel? _selectedBranch;

  bool _submitted = false;
  bool _isSubmitting = false;

  final List<String> interviewTimes = const [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();

    super.dispose();
  }

  bool get nameInvalid =>
      _submitted && _nameController.text.trim().isEmpty;

  bool get phoneInvalid =>
      _submitted &&
      _phoneController.text.trim().length < 8;

  bool get whatsappInvalid =>
      _submitted &&
      (_whatsappController.text.trim().length < 8 ||
          _whatsappController.text.trim().length > 15);

  bool get dobInvalid =>
      _submitted && _dateOfBirth == null;

  bool get branchInvalid =>
      _submitted && _selectedBranch == null;

  bool get dayInvalid =>
      _submitted && _selectedInterviewDay == null;

  bool get timeInvalid =>
      _submitted && _selectedInterviewTime == null;

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final result = await showDatePicker(
      context: context,
      initialDate: DateTime(
        now.year - 10,
        now.month,
        now.day,
      ),
      firstDate: DateTime(1950),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xffc000d9),
              surface: Color(0xff21104e),
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() {
        _dateOfBirth = result;
      });
    }
  }

  String _formatApiDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
    });

    if (nameInvalid ||
        phoneInvalid ||
        whatsappInvalid ||
        dobInvalid ||
        branchInvalid ||
        dayInvalid ||
        timeInvalid) {
      return;
    }

    final request = Interviewrequestmodel(
      branch: _selectedBranch!.name,
      dateOfBirth: _formatApiDate(_dateOfBirth!),
      interviewDate: _formatApiDate(DateTime.now()),
      interviewDay: _selectedInterviewDay!,
      interviewTime: _selectedInterviewTime!,
      isDone: false,
      phoneNumber: _phoneController.text.trim(),
      referral: '',
      studentName: _nameController.text.trim(),
      whatsApp: _whatsappController.text.trim(),
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final message =
          await ref.read(interviewProvider(request).future);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

      setState(() {
        _submitted = false;
        _nameController.clear();
        _phoneController.clear();
        _whatsappController.clear();
        _dateOfBirth = null;
        _selectedBranch = null;
        _selectedInterviewDay = null;
        _selectedInterviewTime = null;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysAsync = ref.watch(interviewDaysProvider);
    final branchesAsync = ref.watch(branchesProvider);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: _StarryBackground(),
          ),

          Positioned.fill(
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final horizontalPadding = width < 600
                      ? 20.0
                      : width < 1000
                          ? 32.0
                          : 42.0;

                  final titleSize = width < 600
                      ? 30.0
                      : width < 1000
                          ? 36.0
                          : 43.0;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: width < 800 ? 105 : 120,
                      bottom: 100,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1600,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'REGISTER INTERVIEW',
                                style: TextStyle(
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),

                              const SizedBox(height: 36),

                              _FormItem(
                                englishLabel: 'Student Name',
                                arabicLabel: 'اسم الطالب',
                                icon: Icons.person_outline,
                                child: _TextInput(
                                  controller: _nameController,
                                  hint: '',
                                ),
                                error: nameInvalid
                                    ? 'Enter Student Name.'
                                    : null,
                              ),

                              const SizedBox(height: 27),

                              _FormItem(
                                englishLabel: 'Phone Number',
                                arabicLabel: 'رقم الهاتف',
                                icon: Icons.phone_outlined,
                                child: _PhoneInput(
                                  controller: _phoneController,
                                  hint: 'Phone number',
                                ),
                                error: phoneInvalid
                                    ? 'Please enter a valid phone number.'
                                    : null,
                              ),

                              const SizedBox(height: 27),

                              _FormItem(
                                englishLabel: 'WhatsApp Number',
                                arabicLabel: 'رقم الواتساب',
                                icon: Icons.wechat_outlined,
                                child: _PhoneInput(
                                  controller:
                                      _whatsappController,
                                  hint: 'WhatsApp number',
                                ),
                                note:
                                    'Note: You will receive your interview confirmation message on WhatsApp.',
                                error: whatsappInvalid
                                    ? 'Please enter a valid WhatsApp number (8-15 digits).'
                                    : null,
                              ),

                              const SizedBox(height: 24),

                              _FormItem(
                                englishLabel: 'Date Of Birth',
                                arabicLabel: 'تاريخ الميلاد',
                                icon:
                                    Icons.calendar_month_outlined,
                                child: _DateInput(
                                  date: _dateOfBirth,
                                  onTap: _selectDate,
                                ),
                                error: dobInvalid
                                    ? 'Please enter Date of Birth.'
                                    : null,
                              ),

                              const SizedBox(height: 18),

                              branchesAsync.when(
                                loading: () => _FormItem(
                                  englishLabel: 'Branch',
                                  arabicLabel: 'الفرع',
                                  icon:
                                      Icons.business_outlined,
                                  child:
                                      const _LoadingInput(),
                                ),
                                error: (error, stack) =>
                                    _FormItem(
                                  englishLabel: 'Branch',
                                  arabicLabel: 'الفرع',
                                  icon:
                                      Icons.business_outlined,
                                  child: _ErrorInput(
                                    message:
                                        'Could not load branches',
                                    onRetry: () {
                                      ref.invalidate(
                                        branchesProvider,
                                      );
                                    },
                                  ),
                                  error: branchInvalid
                                      ? 'Please select a Branch.'
                                      : null,
                                ),
                                data: (branches) =>
                                    _FormItem(
                                  englishLabel: 'Branch',
                                  arabicLabel: 'الفرع',
                                  icon:
                                      Icons.business_outlined,
                                  child:
                                      _DropdownInput<BranchModel>(
                                    value: _selectedBranch,
                                    hint: 'Select Branch',
                                    items: branches,
                                    itemText: (branch) =>
                                        branch.name,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedBranch =
                                            value;
                                      });
                                    },
                                  ),
                                  error: branchInvalid
                                      ? 'Please select a Branch.'
                                      : null,
                                ),
                              ),

                              const SizedBox(height: 23),

                              daysAsync.when(
                                loading: () => _FormItem(
                                  englishLabel:
                                      'Interview Day',
                                  arabicLabel: 'يوم المقابلة',
                                  icon: Icons
                                      .calendar_month_outlined,
                                  child:
                                      const _LoadingInput(),
                                ),
                                error: (error, stack) =>
                                    _FormItem(
                                  englishLabel:
                                      'Interview Day',
                                  arabicLabel: 'يوم المقابلة',
                                  icon: Icons
                                      .calendar_month_outlined,
                                  child: _ErrorInput(
                                    message:
                                        'Could not load interview days',
                                    onRetry: () {
                                      ref.invalidate(
                                        interviewDaysProvider,
                                      );
                                    },
                                  ),
                                  error: dayInvalid
                                      ? 'Please select an Interview Day.'
                                      : null,
                                ),
                                data: (days) => _FormItem(
                                  englishLabel:
                                      'Interview Day',
                                  arabicLabel: 'يوم المقابلة',
                                  icon: Icons
                                      .calendar_month_outlined,
                                  child:
                                      _DropdownInput<String>(
                                    value:
                                        _selectedInterviewDay,
                                    hint:
                                        'Select Interview Day',
                                    items: days,
                                    itemText: (day) => day,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedInterviewDay =
                                            value;
                                      });
                                    },
                                  ),
                                  error: dayInvalid
                                      ? 'Please select an Interview Day.'
                                      : null,
                                ),
                              ),

                              const SizedBox(height: 23),

                              _FormItem(
                                englishLabel:
                                    'Interview Time',
                                arabicLabel: 'وقت المقابلة',
                                icon:
                                    Icons.access_time_outlined,
                                child:
                                    _DropdownInput<String>(
                                  value:
                                      _selectedInterviewTime,
                                  hint:
                                      'Select Interview Time',
                                  items: interviewTimes,
                                  itemText: (time) => time,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedInterviewTime =
                                          value;
                                    });
                                  },
                                ),
                                error: timeInvalid
                                    ? 'Please select an Interview Time.'
                                    : null,
                              ),

                              const SizedBox(height: 17),

                              Align(
                                alignment:
                                    Alignment.centerLeft,
                                child: _SubmitButton(
                                  onPressed: _submit,
                                  isSubmitting: _isSubmitting,
                                ),
                              ),

                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const Positioned(
            top: 18,
            left: 20,
            right: 20,
            child: _NavigationBar(),
          ),

          Positioned(
            right: 25,
            bottom: 25,
            child: _WhatsAppButton(
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// NAVIGATION BAR
// ---------------------------------------------------------------------------

class _NavigationBar extends StatelessWidget {
  const _NavigationBar();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 850) {
          return Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xff160b34)
                  .withOpacity(.92),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.white.withOpacity(.18),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  height: 60,
                  child: Image.asset(
                    'assets/Jupiter Logo raw.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Text(
                        'JUPITER',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 15),
              ],
            ),
          );
        }

        return Container(
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xff160b34)
                .withOpacity(.88),
            borderRadius: BorderRadius.circular(52),
            border: Border.all(
              color: Colors.white.withOpacity(.18),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 25),

              SizedBox(
                width: 145,
                height: 80,
                child: Image.asset(
                  'assets/Jupiter Logo raw.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                    return const Text(
                      'JUPITER\nACADEMY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    );
                  },
                ),
              ),

              const Spacer(),

              Container(
                height: 58,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xff241448)
                      .withOpacity(.92),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Row(
                  children: [
                    _NavItem(text: 'Home'),
                    _NavItem(text: 'Courses'),
                    _NavItem(text: 'Competitions'),
                    _NavItem(text: 'Students'),
                    _NavItem(text: 'Team'),
                  ],
                ),
              ),

              const Spacer(),

              Container(
                height: 52,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffe900bb),
                      Color(0xffa700e6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 18),
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String text;

  const _NavItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xffeeeaf7),
          fontSize: 19,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FORM ITEM
// ---------------------------------------------------------------------------

class _FormItem extends StatelessWidget {
  final String englishLabel;
  final String arabicLabel;
  final IconData icon;
  final Widget child;
  final String? error;
  final String? note;

  const _FormItem({
    required this.englishLabel,
    required this.arabicLabel,
    required this.icon,
    required this.child,
    this.error,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 600;

            return Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: compact ? 24 : 29,
                ),

                const SizedBox(width: 12),

                Flexible(
                  child: Text(
                    englishLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: compact ? 18 : 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Flexible(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      arabicLabel,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: compact ? 18 : 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 17),

        child,

        if (note != null) ...[
          const SizedBox(height: 12),
          Text(
            note!,
            style: const TextStyle(
              color: Color(0xff00d9ff),
              fontSize: 16,
            ),
          ),
        ],

        if (error != null) ...[
          const SizedBox(height: 6),
          Text(
            error!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TEXT INPUT
// ---------------------------------------------------------------------------

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _TextInput({
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Color(0xff555967),
          fontSize: 19,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xff737783),
            fontSize: 19,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PHONE INPUT
// ---------------------------------------------------------------------------

class _PhoneInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _PhoneInput({
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Container(
            width: 166,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Color(0xffdddddd),
                  width: 1,
                ),
              ),
            ),
            child: const Row(
              children: [
                SizedBox(width: 13),
                Text(
                  '🇪🇬',
                  style: TextStyle(fontSize: 27),
                ),
                SizedBox(width: 8),
                Text(
                  '+20',
                  style: TextStyle(
                    color: Color(0xff656873),
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff666a72),
                  size: 28,
                ),
                SizedBox(width: 14),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: Color(0xff555967),
                fontSize: 19,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xff737783),
                  fontSize: 19,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DATE INPUT
// ---------------------------------------------------------------------------

class _DateInput extends StatelessWidget {
  final DateTime? date;
  final VoidCallback onTap;

  const _DateInput({
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 57,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: 13),
        child: Row(
          children: [
            Expanded(
              child: Text(
                date == null
                    ? 'mm/dd/yyyy'
                    : '${date!.month.toString().padLeft(2, '0')}/'
                        '${date!.day.toString().padLeft(2, '0')}/'
                        '${date!.year}',
                style: TextStyle(
                  color: date == null
                      ? const Color(0xff737783)
                      : const Color(0xff555967),
                  fontSize: 19,
                ),
              ),
            ),
            const Icon(
              Icons.calendar_month,
              color: Colors.black,
              size: 23,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// GENERIC DROPDOWN
// ---------------------------------------------------------------------------

class _DropdownInput<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final String Function(T item) itemText;
  final ValueChanged<T?> onChanged;

  const _DropdownInput({
    required this.value,
    required this.hint,
    required this.items,
    required this.itemText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 13),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xff60646c),
          ),
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xff737783),
              fontSize: 19,
            ),
          ),
          style: const TextStyle(
            color: Color(0xff555967),
            fontSize: 19,
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemText(item),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// LOADING INPUT
// ---------------------------------------------------------------------------

class _LoadingInput extends StatelessWidget {
  const _LoadingInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      alignment: Alignment.centerLeft,
      padding:
          const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xff5730a8),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ERROR INPUT
// ---------------------------------------------------------------------------

class _ErrorInput extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorInput({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      padding:
          const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SUBMIT BUTTON
// ---------------------------------------------------------------------------

class _SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSubmitting;

  const _SubmitButton({
    required this.onPressed,
    required this.isSubmitting,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 164,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff0b497c),
          width: 2,
        ),
      ),
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xff5730a8),
          foregroundColor: Colors.white,
          disabledBackgroundColor:
              const Color(0xff5730a8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: isSubmitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    size: 25,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WHATSAPP BUTTON
// ---------------------------------------------------------------------------

class _WhatsAppButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _WhatsAppButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          color: const Color(0xff19bd75),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(.25),
            width: 1,
          ),
        ),
        child: const Icon(
          Icons.phone_in_talk,
          color: Colors.white,
          size: 38,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BACKGROUND
// ---------------------------------------------------------------------------

class _StarryBackground extends StatefulWidget {
  const _StarryBackground();

  @override
  State<_StarryBackground> createState() =>
      _StarryBackgroundState();
}

class _StarryBackgroundState
    extends State<_StarryBackground> {
  late final List<_Particle> particles;

  @override
  void initState() {
    super.initState();

    final random = math.Random(17);

    particles = List.generate(
      180,
      (_) => _Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius:
            1.0 + random.nextDouble() * 3.2,
        opacity:
            .15 + random.nextDouble() * .6,
        blur: random.nextDouble() * 7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackgroundPainter(particles),
      child: const SizedBox.expand(),
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double radius;
  final double opacity;
  final double blur;

  const _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.opacity,
    required this.blur,
  });
}

class _BackgroundPainter extends CustomPainter {
  final List<_Particle> particles;

  const _BackgroundPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xff10164d),
          Color(0xff19105a),
          Color(0xff390b63),
          Color(0xff850b78),
        ],
      ).createShader(rect);

    canvas.drawRect(rect, background);

    final random = math.Random(5);

    final glows = [
      Offset(size.width * .58, size.height * .12),
      Offset(size.width * .88, size.height * .35),
      Offset(size.width * .42, size.height * .73),
      Offset(size.width * .15, size.height * .86),
    ];

    for (final position in glows) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xff8f43ff)
                .withOpacity(.18),
            const Color(0xff8f43ff)
                .withOpacity(.0),
          ],
        ).createShader(
          Rect.fromCircle(
            center: position,
            radius: 220,
          ),
        );

      canvas.drawCircle(
        position,
        220,
        glowPaint,
      );
    }

    for (final particle in particles) {
      final position = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );

      final paint = Paint()
        ..color = Colors.white
            .withOpacity(particle.opacity);

      canvas.drawCircle(
        position,
        particle.radius,
        paint,
      );

      if (particle.blur > 3) {
        final glow = Paint()
          ..color = const Color(0xffb68aff)
              .withOpacity(
                particle.opacity * .45,
              )
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            particle.blur,
          );

        canvas.drawCircle(
          position,
          particle.radius * 1.4,
          glow,
        );
      }

      if (random.nextBool()) {
        final tinyPaint = Paint()
          ..color = const Color(0xff8ac6ff)
              .withOpacity(.2);

        canvas.drawCircle(
          Offset(
            position.dx + 4,
            position.dy + 3,
          ),
          .8,
          tinyPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}