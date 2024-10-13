class Urls {
  static const String _baseUrl = 'https://jobnect.bugbuild.com/api/v10';
  static const String signup = '$_baseUrl/registration';
  static const String verifySignup = '$_baseUrl/registration-verification';
  static const String login = '$_baseUrl/login';
  static const String sendOtpToEmail =
      '$_baseUrl/password-reset-email-verification';
  static const String verifyOtp = '$_baseUrl/reset-password';
  static const String categories = '$_baseUrl/job-category';
  static const String companies = '$_baseUrl/companies';
  static const String featuredCompanies = '$_baseUrl/featured-companies';
  static const String notifications = '$_baseUrl/notifications';
  static const String latestJobs = '$_baseUrl/jobs/recent';
  static const String filterJobs = '$_baseUrl/jobs-filter';
  static const String popularJobs = '$_baseUrl/jobs/popular';
  static const String appliedJobs = '$_baseUrl/applicant/job/applied';
  static const String bookmarkedJobs = '$_baseUrl/applicant/job/bookmarks';
  static const String bookmarkedStore =
      '$_baseUrl/applicant/job/bookmark/store';
  static const String applyJob = '$_baseUrl/applicant/job-apply';
  static const String resumeDetails = '$_baseUrl/applicant/resume/details';
  static const String updateProfile = '$_baseUrl/applicant/profile/update';
  static const String updateImage = '$_baseUrl/applicant/image/update';
  static const String designations = '$_baseUrl/designations';

  static const String filterCategories = '$_baseUrl/categories';
  static const String jobTypes = '$_baseUrl/job-types';
  static const String jobTypesFilter = '$_baseUrl/job-types-filter';
  static const String skills = '$_baseUrl/skills';

  static const String jobLevels = '$_baseUrl/job-levels';
  static const String educationLevels = '$_baseUrl/education-levels';
  static const String appLanguages = '$_baseUrl/app-languages';
  static const String appSliders = '$_baseUrl/app-sliders';
  static const String appSettings = '$_baseUrl/settings';
  static String jobDetails(id) => '$_baseUrl/jobs/details/$id';
  static String companyDetails(id) => '$_baseUrl/company/details/$id';
  static String companyJobs(id) => '$_baseUrl/company/jobs/$id';
  static String appTexts(code) =>
      '$_baseUrl/app-language/terms?language_code=$code';

  static const String editResumePersonalInfo =
      '$_baseUrl/resume/update/personal-info';
  static const String editResumeAddressInfo =
      '$_baseUrl/resume/update/address-info';
  static const String editResumeCareerInfo =
      '$_baseUrl/resume/update/career-info';

  static const String editResumeAddExperience =
      '$_baseUrl/resume/experience/store';
  static const String editResumeAddEducation =
      '$_baseUrl/resume/education/store';
  static const String editResumeAddTraining = '$_baseUrl/resume/training/store';
  static const String editResumeAddLanguage = '$_baseUrl/resume/language/store';
  static const String editResumeAddReference =
      '$_baseUrl/resume/reference/store';

  static const String editResumeUpdateExperience =
      '$_baseUrl/resume/experience/update';
  static const String editResumeUpdateEducation =
      '$_baseUrl/resume/education/update';
  static const String editResumeUpdateTraining =
      '$_baseUrl/resume/training/update';
  static const String editResumeUpdateLanguage =
      '$_baseUrl/resume/language/update';
  static const String editResumeUpdateReference =
      '$_baseUrl/resume/reference/update';

  static String editResumeDeleteExperience(id) =>
      '$_baseUrl/resume/experience/delete/$id';
  static String editResumeDeleteEducation(id) =>
      '$_baseUrl/resume/education/delete/$id';
  static String editResumeDeleteTraining(id) =>
      '$_baseUrl/resume/training/delete/$id';
  static String editResumeDeleteLanguage(id) =>
      '$_baseUrl/resume/language/delete/$id';
  static String editResumeDeleteReference(id) =>
      '$_baseUrl/resume/reference/delete/$id';
}
