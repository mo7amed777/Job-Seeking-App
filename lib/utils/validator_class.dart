class ValidatorClass {
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "please enter an email";
    } else if (!RegExp('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
      return "please enter valid email";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "please enter name";
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return "only alphabets allowed";
    }
    return null;
  }

  String? validateEmptyField(String? value) {
    if (value!.isEmpty) {
      return "field can't be empty";
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value!.isEmpty) {
      return "please enter mobile number";
    } else if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(value)) {
      return "please enter valid number";
    }
    return null;
  }

  String? noValidationRequired(String? value) {
    return null;
  }
}

// final _formKey = GlobalKey<FormState>();
//
//   TextFormField(
//     decoration: InputDecoration(labelText: 'Email'),
//     validator: (value) {
//       if (value.isEmpty) {
//       return 'Please enter your email address';
//       }
//   // Additional validation logic (e.g., email format check)
//       return null; // Return null if validation passes
//       },
//       onSaved: (value) {
//   // Save form data here
//       },
//     ),
//
//     void _submitForm() async {
//       if (_formKey.currentState.validate()) {
//     // Save form data
//       _formKey.currentState.save();
//
//     // Make API call
//       var response = await yourApiCall();
//
//     // Check response status
//     if (response.statusCode == 200) {
//     // Success scenario: Navigate or show success message
//     } else {
//     // Handle API validation errors
//     Map<String, dynamic> responseData = json.decode(response.body);
//     String errorMessage = responseData['error'];
//
//     // Set error message in TextFormField
//     _updateTextFieldError('email', errorMessage); // Replace 'email' with your form field identifier
//       }
//     }
//   }
//
//     void _updateTextFieldError(String fieldName, String errorMessage) {
//     // Access the FormState using the GlobalKey
//     FormState formState = _formKey.currentState;
//
//     // Update the error text of the corresponding TextFormField
//     formState?.fields[fieldName]?.errorText = errorMessage;
//
//     // Mark the form as dirty to ensure the UI updates
//     formState?.setState(() {});
//   }
