import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import model
import 'package:test1/models/user_entity.dart';

//import bloc files
import 'bloc/add_user_bloc.dart';
import 'bloc/add_user_event.dart';
import 'bloc/add_user_state.dart';

//import different form screens
import 'package:test1/add_user/add_User_Screens/form1.dart';
import 'package:test1/add_user/add_User_Screens/form2.dart';
import 'package:test1/add_user/add_User_Screens/form3.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> with SingleTickerProviderStateMixin {
  //tabcontroller for forms
  late TabController _tabController;
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];
  bool _loaderShown = false;
  
  //Init state then need a dispose state since using controlelr
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //
  //  Functions for submiting form data
  //

  //move to next tab by incrementing index
  void _nextStep(BuildContext context, int currentStep) {
    final form = _formKeys[currentStep].currentState;
    if (form != null && form.validate()) {
      form.save();
      context.read<UserBloc>().add(NextStep());
    }
  }

  //move to prev tab by decrementing index
  void _prevStep(BuildContext context) {
    context.read<UserBloc>().add(PreviousStep());
  }

  //submit function
  void _submit(BuildContext context) {
    context.read<UserBloc>().add(const SubmitUserRequested());
  }

  //loader
  Future<void> _showLoader(BuildContext context) async {
    if (_loaderShown) return;
    _loaderShown = true;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    _loaderShown = false;
  }

  void _hideLoaderIfOpen(BuildContext context) {
    if (_loaderShown) {
      Navigator.of(context, rootNavigator: true).pop();
      _loaderShown = false;
    }
  }

  //widget for retyr
  Future<void> _showRetryDialog(BuildContext context, String message) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<UserBloc>().add(const SubmitUser());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  //function for succes
  Future<void> _showSuccessDialogAndPop(BuildContext context, String message, UserEntity user) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Success', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              Navigator.of(context).pop(user);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  //build forms
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) async {
          //make sure tabbarview is on the same page as bloc state
          if (_tabController.index != state.currentStep) {
            _tabController.animateTo(state.currentStep);
          }

          //Load Icon
          if (state.isSubmitting) {
            await _showLoader(context);
          } else {
            _hideLoaderIfOpen(context);
          }

          //Retry, mock error thingy maboib
          if (state.showRetryDialog && !state.isSubmitting) {
            await _showRetryDialog(context, state.errorMessage ?? 'Something went wrong. Please try again.');
          }

          //Success so push registration
          if (state.isSubmissionSuccess) {
            await _showSuccessDialogAndPop(context, state.serverMessage ?? 'User registered successfully!', state.user,);
            if (mounted) {
              context.read<UserBloc>().add(const ResetForm());
            }
          }

        },

        //build all three form screens
        builder: (context, state) {
          return Column(
            children: [
              //Step number for form
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "${state.currentStep + 1} out of 3",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              //Form builder
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FormOne(formKey: _formKeys[0]),
                    FormTwo(formKey: _formKeys[1]),
                    const FormThree(),
                  ],
                ),
              ),
            ],
          );
        },
      ),

      //Persistent Bottom Button
      bottomNavigationBar: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [

                  //Output back button if not at page 1
                  if (state.currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _prevStep(context),
                        child: const Text('Back'),
                      ),
                    ),

                  //Space box
                  if (state.currentStep > 0) const SizedBox(width: 12),

                  //Output Next button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.currentStep < 2) {
                          _nextStep(context, state.currentStep);
                        } else {
                          _submit(context);
                        }
                      },
                      child: Text(state.currentStep < 2 ? 'Review' : 'Continue'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}