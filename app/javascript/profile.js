function profile() {
  const height = document.getElementById('height').innerText;
  const weight = document.getElementById('weight').innerText;
  const age = document.getElementById('age').innerText;
  const gender = document.getElementById('gender').innerText;
  const bmr = document.getElementById('bmr');


  if (gender == "1") {
    bmr.innerHTML = parseInt((13.397 * weight + 4.799 * height - 5.677 * age + 88.362), 10)
  } else {
    bmr.innerHTML = parseInt((9.247 * weight + 3.098 * height - 4.33 * age + 447.593), 10)
  }
}
window.addEventListener('load', profile)