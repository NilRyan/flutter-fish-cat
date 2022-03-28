enum Gender {
  M , F, none
}

Gender genderFromString(String gender) {
    if (gender == 'Male') {
      return Gender.M;
    }
    if (gender == 'Female') {
      return Gender.F;
    }
    return Gender.none;
  }