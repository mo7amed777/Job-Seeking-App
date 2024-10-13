class AppTextModel {
  bool? success;
  String? message;
  AppText? appTexts;

  AppTextModel({this.success, this.message, this.appTexts});

  AppTextModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    appTexts = json['data'] != null ? AppText.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (appTexts != null) {
      data['data'] = appTexts!.toJson();
    }
    return data;
  }
}

class AppText {
  String? languageName;
  String? languageCode;
  String? textDirection;
  Terms? terms;

  AppText({this.languageName, this.languageCode, this.textDirection, this.terms});

  AppText.fromJson(Map<String, dynamic> json) {
    languageName = json['language_name'];
    languageCode = json['language_code'];
    textDirection = json['text_direction'];
    terms = json['terms'] != null ? Terms.fromJson(json['terms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language_name'] = languageName;
    data['language_code'] = languageCode;
    data['text_direction'] = textDirection;
    if (terms != null) {
      data['terms'] = terms!.toJson();
    }
    return data;
  }
}

class Terms {
  String? changePassword;
  String? notification;
  String? logout;
  String? updateProfile;
  String? seeDetails;
  String? next;
  String? skip;
  String? back;
  String? yes;
  String? no;
  String? getStarted;
  String? signUp;
  String? login;
  String? selectAccountTitle;
  String? selectAccountSub;
  String? iWantJob;
  String? iWantEmployee;
  String? welcomeTitle;
  String? welcomeSub;
  String? continueGuest;
  String? signupWithGoogle;
  String? signupCompanyTitle;
  String? signupUserTitle;
  String? loginWithGoogle;
  String? loginTitle;
  String? forgotPassword;
  String? forgotPassTitle;
  String? emailHintText;
  String? passwordHintText;
  String? fullName;
  String? companyName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  String? confirmNewPassword;
  String? searchForJobs;
  String? validateEmptyField;
  String? home;
  String? explore;
  String? applied;
  String? profile;
  String? viewAll;
  String? allCategory;
  String? jobCategories;
  String? companies;
  String? allCompany;
  String? recommended;
  String? recommendedJobs;
  String? latestJobs;
  String? foundJobs;
  String? appliedJobs;
  String? bookmarkJobs;
  String? viewResume;
  String? changePasswordSub;
  String? logoutWarning;
  String? setting;
  String? language;
  String? darkMode;
  String? overview;
  String? availableJobs;
  String? availableVacancy;
  String? about;
  String? video;
  String? address;
  String? salary;
  String? jobType;
  String? jobDetails;
  String? jobDescription;
  String? skills;
  String? visitCompany;
  String? applicationDeadline;
  String? searchResult;
  String? saveAndUpdate;
  String? delete;
  String? deleteAll;
  String? oldPassword;
  String? newPassword;
  String? myProfile;
  String? careerObjective;
  String? personalDetails;
  String? workExperience;
  String? academicQualification;
  String? trainingSummary;
  String? reference;
  String? name;
  String? fathersName;
  String? mothersName;
  String? dateOfBirth;
  String? gender;
  String? nationality;
  String? maritalStatus;
  String? presentAddress;
  String? permanentAddress;
  String? careerSummary;
  String? presentSalary;
  String? expectedSalary;
  String? jobLevel;
  String? addNewExperience;
  String? editExperience;
  String? organizationName;
  String? employer;
  String? designation;
  String? duration;
  String? addNewQualification;
  String? editQualification;
  String? educationLevel;
  String? instituteName;
  String? major;
  String? exam;
  String? result;
  String? addNewTraining;
  String? editTraining;
  String? trainingName;
  String? institute;
  String? topic;
  String? addNewLanguage;
  String? editLanguage;
  String? languageName;
  String? reading;
  String? writing;
  String? speaking;
  String? addNewReference;
  String? editReference;
  String? organization;
  String? relation;
  String? startDate;
  String? endDate;
  String? passingYear;
  String? location;
  String? bookmark;
  String? vacancy;
  String? applyNow;
  String? saveAndContinue;
  String? resetPassTitle;
  String? verify;
  String? otpHintText;
  String? filterJobs;
  String? category;
  String? subCategory;
  String? salaryRange;
  String? searchJobs;

  Terms({
    this.changePassword,
    this.notification,
    this.logout,
    this.updateProfile,
    this.seeDetails,
    this.next,
    this.skip,
    this.back,
    this.yes,
    this.no,
    this.getStarted,
    this.signUp,
    this.login,
    this.selectAccountTitle,
    this.selectAccountSub,
    this.iWantJob,
    this.iWantEmployee,
    this.welcomeTitle,
    this.welcomeSub,
    this.continueGuest,
    this.signupWithGoogle,
    this.signupCompanyTitle,
    this.signupUserTitle,
    this.loginWithGoogle,
    this.loginTitle,
    this.forgotPassword,
    this.forgotPassTitle,
    this.emailHintText,
    this.passwordHintText,
    this.fullName,
    this.companyName,
    this.email,
    this.phone,
    this.password,
    this.confirmPassword,
    this.confirmNewPassword,
    this.searchForJobs,
    this.validateEmptyField,
    this.home,
    this.explore,
    this.applied,
    this.profile,
    this.viewAll,
    this.allCategory,
    this.jobCategories,
    this.companies,
    this.allCompany,
    this.recommended,
    this.recommendedJobs,
    this.latestJobs,
    this.foundJobs,
    this.appliedJobs,
    this.bookmarkJobs,
    this.viewResume,
    this.changePasswordSub,
    this.logoutWarning,
    this.setting,
    this.language,
    this.darkMode,
    this.overview,
    this.availableJobs,
    this.availableVacancy,
    this.about,
    this.video,
    this.address,
    this.salary,
    this.jobType,
    this.jobDetails,
    this.jobDescription,
    this.skills,
    this.visitCompany,
    this.applicationDeadline,
    this.searchResult,
    this.saveAndUpdate,
    this.delete,
    this.deleteAll,
    this.oldPassword,
    this.newPassword,
    this.myProfile,
    this.careerObjective,
    this.personalDetails,
    this.workExperience,
    this.academicQualification,
    this.trainingSummary,
    this.reference,
    this.name,
    this.fathersName,
    this.mothersName,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.maritalStatus,
    this.presentAddress,
    this.permanentAddress,
    this.careerSummary,
    this.presentSalary,
    this.expectedSalary,
    this.jobLevel,
    this.addNewExperience,
    this.editExperience,
    this.organizationName,
    this.employer,
    this.designation,
    this.duration,
    this.addNewQualification,
    this.editQualification,
    this.educationLevel,
    this.instituteName,
    this.major,
    this.exam,
    this.result,
    this.addNewTraining,
    this.editTraining,
    this.trainingName,
    this.institute,
    this.topic,
    this.addNewLanguage,
    this.editLanguage,
    this.languageName,
    this.reading,
    this.writing,
    this.speaking,
    this.addNewReference,
    this.editReference,
    this.organization,
    this.relation,
    this.startDate,
    this.endDate,
    this.passingYear,
    this.location,
    this.bookmark,
    this.vacancy,
    this.applyNow,
    this.saveAndContinue,
    this.resetPassTitle,
    this.verify,
    this.otpHintText,
    this.filterJobs,
    this.category,
    this.subCategory,
    this.salaryRange,
    this.searchJobs,
  });

  Terms.fromJson(Map<String, dynamic> json) {
    changePassword = json['changePassword'];
    notification = json['notification'];
    logout = json['logout'];
    updateProfile = json['updateProfile'];
    seeDetails = json['seeDetails'];
    next = json['next'];
    skip = json['skip'];
    back = json['back'];
    yes = json['yes'];
    no = json['no'];
    getStarted = json['getStarted'];
    signUp = json['signUp'];
    login = json['login'];
    selectAccountTitle = json['selectAccountTitle'];
    selectAccountSub = json['selectAccountSub'];
    iWantJob = json['iWantJob'];
    iWantEmployee = json['iWantEmployee'];
    welcomeTitle = json['welcomeTitle'];
    welcomeSub = json['welcomeSub'];
    continueGuest = json['continueGuest'];
    signupWithGoogle = json['signupWithGoogle'];
    signupCompanyTitle = json['signupCompanyTitle'];
    signupUserTitle = json['signupUserTitle'];
    loginWithGoogle = json['loginWithGoogle'];
    loginTitle = json['loginTitle'];
    forgotPassword = json['forgotPassword'];
    forgotPassTitle = json['forgotPassTitle'];
    emailHintText = json['emailHintText'];
    passwordHintText = json['passwordHintText'];
    fullName = json['fullName'];
    companyName = json['companyName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    confirmNewPassword = json['confirmNewPassword'];
    searchForJobs = json['searchForJobs'];
    validateEmptyField = json['validateEmptyField'];
    home = json['home'];
    explore = json['explore'];
    applied = json['applied'];
    profile = json['profile'];
    viewAll = json['viewAll'];
    allCategory = json['allCategory'];
    jobCategories = json['jobCategories'];
    companies = json['companies'];
    allCompany = json['allCompany'];
    recommended = json['recommended'];
    recommendedJobs = json['recommendedJobs'];
    latestJobs = json['latestJobs'];
    foundJobs = json['foundJobs'];
    appliedJobs = json['appliedJobs'];
    bookmarkJobs = json['bookmarkJobs'];
    viewResume = json['viewResume'];
    changePasswordSub = json['changePasswordSub'];
    logoutWarning = json['logoutWarning'];
    setting = json['setting'];
    language = json['language'];
    darkMode = json['darkMode'];
    overview = json['overview'];
    availableJobs = json['availableJobs'];
    availableVacancy = json['availableVacancy'];
    about = json['about'];
    video = json['video'];
    address = json['address'];
    salary = json['salary'];
    jobType = json['jobType'];
    jobDetails = json['jobDetails'];
    jobDescription = json['jobDescription'];
    skills = json['skills'];
    visitCompany = json['visitCompany'];
    applicationDeadline = json['applicationDeadline'];
    searchResult = json['searchResult'];
    saveAndUpdate = json['saveAndUpdate'];
    delete = json['delete'];
    deleteAll = json['deleteAll'];
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    myProfile = json['myProfile'];
    careerObjective = json['careerObjective'];
    personalDetails = json['personalDetails'];
    workExperience = json['workExperience'];
    academicQualification = json['academicQualification'];
    trainingSummary = json['trainingSummary'];
    reference = json['reference'];
    name = json['name'];
    fathersName = json['fathersName'];
    mothersName = json['mothersName'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    nationality = json['nationality'];
    maritalStatus = json['maritalStatus'];
    presentAddress = json['presentAddress'];
    permanentAddress = json['permanentAddress'];
    careerSummary = json['careerSummary'];
    presentSalary = json['presentSalary'];
    expectedSalary = json['expectedSalary'];
    jobLevel = json['jobLevel'];
    addNewExperience = json['addNewExperience'];
    editExperience = json['editExperience'];
    organizationName = json['organizationName'];
    employer = json['employer'];
    designation = json['designation'];
    duration = json['duration'];
    addNewQualification = json['addNewQualification'];
    editQualification = json['editQualification'];
    educationLevel = json['educationLevel'];
    instituteName = json['instituteName'];
    major = json['major'];
    exam = json['exam'];
    result = json['result'];
    addNewTraining = json['addNewTraining'];
    editTraining = json['editTraining'];
    trainingName = json['trainingName'];
    institute = json['institute'];
    topic = json['topic'];
    addNewLanguage = json['addNewLanguage'];
    editLanguage = json['editLanguage'];
    languageName = json['languageName'];
    reading = json['reading'];
    writing = json['writing'];
    speaking = json['speaking'];
    addNewReference = json['addNewReference'];
    editReference = json['editReference'];
    organization = json['organization'];
    relation = json['relation'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    passingYear = json['passingYear'];
    location = json['location'];
    bookmark = json['bookmark'];
    vacancy = json['vacancy'];
    applyNow = json['applyNow'];
    saveAndContinue = json['saveAndContinue'];
    resetPassTitle = json['resetPassTitle'];
    verify = json['verify'];
    otpHintText = json['otpHintText'];
    filterJobs = json['filterJobs'];
    category = json['category'];
    subCategory = json['subCategory'];
    salaryRange = json['salaryRange'];
    searchJobs = json['searchJobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['changePassword'] = changePassword;
    data['notification'] = notification;
    data['logout'] = logout;
    data['updateProfile'] = updateProfile;
    data['seeDetails'] = seeDetails;
    data['next'] = next;
    data['skip'] = skip;
    data['back'] = back;
    data['yes'] = yes;
    data['no'] = no;
    data['getStarted'] = getStarted;
    data['signUp'] = signUp;
    data['login'] = login;
    data['selectAccountTitle'] = selectAccountTitle;
    data['selectAccountSub'] = selectAccountSub;
    data['iWantJob'] = iWantJob;
    data['iWantEmployee'] = iWantEmployee;
    data['welcomeTitle'] = welcomeTitle;
    data['welcomeSub'] = welcomeSub;
    data['continueGuest'] = continueGuest;
    data['signupWithGoogle'] = signupWithGoogle;
    data['signupCompanyTitle'] = signupCompanyTitle;
    data['signupUserTitle'] = signupUserTitle;
    data['loginWithGoogle'] = loginWithGoogle;
    data['loginTitle'] = loginTitle;
    data['forgotPassword'] = forgotPassword;
    data['forgotPassTitle'] = forgotPassTitle;
    data['emailHintText'] = emailHintText;
    data['passwordHintText'] = passwordHintText;
    data['fullName'] = fullName;
    data['companyName'] = companyName;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['confirmNewPassword'] = confirmNewPassword;
    data['searchForJobs'] = searchForJobs;
    data['validateEmptyField'] = validateEmptyField;
    data['home'] = home;
    data['explore'] = explore;
    data['applied'] = applied;
    data['profile'] = profile;
    data['viewAll'] = viewAll;
    data['allCategory'] = allCategory;
    data['jobCategories'] = jobCategories;
    data['companies'] = companies;
    data['allCompany'] = allCompany;
    data['recommended'] = recommended;
    data['recommendedJobs'] = recommendedJobs;
    data['latestJobs'] = latestJobs;
    data['foundJobs'] = foundJobs;
    data['appliedJobs'] = appliedJobs;
    data['bookmarkJobs'] = bookmarkJobs;
    data['viewResume'] = viewResume;
    data['changePasswordSub'] = changePasswordSub;
    data['logoutWarning'] = logoutWarning;
    data['setting'] = setting;
    data['language'] = language;
    data['darkMode'] = darkMode;
    data['overview'] = overview;
    data['availableJobs'] = availableJobs;
    data['availableVacancy'] = availableVacancy;
    data['about'] = about;
    data['video'] = video;
    data['address'] = address;
    data['salary'] = salary;
    data['jobType'] = jobType;
    data['jobDetails'] = jobDetails;
    data['jobDescription'] = jobDescription;
    data['skills'] = skills;
    data['visitCompany'] = visitCompany;
    data['applicationDeadline'] = applicationDeadline;
    data['searchResult'] = searchResult;
    data['saveAndUpdate'] = saveAndUpdate;
    data['delete'] = delete;
    data['deleteAll'] = deleteAll;
    data['oldPassword'] = oldPassword;
    data['newPassword'] = newPassword;
    data['myProfile'] = myProfile;
    data['careerObjective'] = careerObjective;
    data['personalDetails'] = personalDetails;
    data['workExperience'] = workExperience;
    data['academicQualification'] = academicQualification;
    data['trainingSummary'] = trainingSummary;
    data['reference'] = reference;
    data['name'] = name;
    data['fathersName'] = fathersName;
    data['mothersName'] = mothersName;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['maritalStatus'] = maritalStatus;
    data['presentAddress'] = presentAddress;
    data['permanentAddress'] = permanentAddress;
    data['careerSummary'] = careerSummary;
    data['presentSalary'] = presentSalary;
    data['expectedSalary'] = expectedSalary;
    data['jobLevel'] = jobLevel;
    data['addNewExperience'] = addNewExperience;
    data['editExperience'] = editExperience;
    data['organizationName'] = organizationName;
    data['employer'] = employer;
    data['designation'] = designation;
    data['duration'] = duration;
    data['addNewQualification'] = addNewQualification;
    data['editQualification'] = editQualification;
    data['educationLevel'] = educationLevel;
    data['instituteName'] = instituteName;
    data['major'] = major;
    data['exam'] = exam;
    data['result'] = result;
    data['addNewTraining'] = addNewTraining;
    data['editTraining'] = editTraining;
    data['trainingName'] = trainingName;
    data['institute'] = institute;
    data['topic'] = topic;
    data['addNewLanguage'] = addNewLanguage;
    data['editLanguage'] = editLanguage;
    data['languageName'] = languageName;
    data['reading'] = reading;
    data['writing'] = writing;
    data['speaking'] = speaking;
    data['addNewReference'] = addNewReference;
    data['editReference'] = editReference;
    data['organization'] = organization;
    data['relation'] = relation;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['passingYear'] = passingYear;
    data['location'] = location;
    data['bookmark'] = this.bookmark;
    data['vacancy'] = this.vacancy;
    data['applyNow'] = this.applyNow;
    data['saveAndContinue'] = this.saveAndContinue;
    data['resetPassTitle'] = this.resetPassTitle;
    data['verify'] = this.verify;
    data['otpHintText'] = this.otpHintText;
    data['filterJobs'] = this.filterJobs;
    data['category'] = this.category;
    data['subCategory'] = this.subCategory;
    data['salaryRange'] = this.salaryRange;
    data['searchJobs'] = this.searchJobs;
    return data;
  }
}
