import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../_core_/app_widgets/app_button.dart';
import '../../../_core_/app_widgets/app_text_field.dart';
import '../../../_core_/utils/validators.dart';
import '../../dashboard/view_model/dashboard_view_model.dart';
import '../view_model/post_form_view_model.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: dashboardViewModel.selectedPost?.title,
    );
    _bodyController = TextEditingController(
      text: dashboardViewModel.selectedPost?.body,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = dashboardViewModel.selectedPost != null;

    return ListenableBuilder(
      listenable: postFormViewModel,
      builder: (context, child) {
        return Stack(
          children: [
            /// Main Form area.
            Scaffold(
              backgroundColor: const Color(0xFFF5F7FA),
              appBar: AppBar(
                title: Text(
                  isEdit ? 'E D I T  P O S T' : 'C R E A T E  P O S T',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  autovalidateMode: .onUserInteraction,
                  child: Column(
                    children: [
                      /// Post Title
                      AppTextField(
                        controller: _titleController,
                        label: 'Post Title',
                        validator: (value) => Validators.minLength(
                          value,
                          3,
                          fieldName: 'Post Title',
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// Post Body
                      AppTextField(
                        controller: _bodyController,
                        label: 'Post Body',
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        validator: (value) => Validators.minLength(
                          value,
                          5,
                          fieldName: 'Post Body',
                        ),
                      ),

                      SizedBox(height: 100.h),

                      /// Create / Edit Post Button.
                      AppButton(
                        text: isEdit ? 'Edit Post' : 'Create Post',
                        isLoading: postFormViewModel.isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            isEdit
                                ? postFormViewModel.updatePost(
                                    title: _titleController.text.trim(),
                                    body: _bodyController.text.trim(),
                                  )
                                : postFormViewModel.createPost(
                                    title: _titleController.text.trim(),
                                    body: _bodyController.text.trim(),
                                  );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Loading overlay.
            if (postFormViewModel.isLoading) ...[
              Scaffold(backgroundColor: Colors.black.withValues(alpha: 0.5)),
            ],
          ],
        );
      },
    );
  }
}
