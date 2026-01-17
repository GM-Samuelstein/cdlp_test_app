import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../_core_/app_widgets/app_button.dart';
import '../../../_core_/app_widgets/app_text_field.dart';
import '../../../_core_/utils/validators.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ListenableBuilder(
        listenable: loginViewModel,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F7FA),
            body: Stack(
              children: [
                /// Main login screen.
                SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: .onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 100.h),

                          Icon(
                            Icons.lock_outline,
                            size: 56.sp,
                            color: Colors.black87,
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            'Welcome!',
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Login to continue',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                          ),

                          SizedBox(height: 40.h),

                          /// Email Field
                          AppTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email address',
                            prefixIcon: Icons.email_outlined,
                            validator: Validators.email,
                          ),

                          SizedBox(height: 20.h),

                          /// Password Field
                          AppTextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            label: 'Password',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) => Validators.minLength(
                              value,
                              6,
                              fieldName: 'Password',
                            ),
                          ),

                          SizedBox(height: 100.h),

                          /// Login Button
                          AppButton(
                            text: 'Login',
                            isLoading: loginViewModel.isLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();

                                loginViewModel.login(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                              }
                            },
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Loading overlay.
                if (loginViewModel.isLoading) ...[
                  Scaffold(
                    backgroundColor: Colors.black.withValues(alpha: 0.5),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
