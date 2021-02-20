function user_show() {
  const weightUser = document.getElementById('weight-user').innerText;
  const runUser = document.getElementById('run-user').innerText;
  const runUserCal = document.getElementById('run-user-cal');
  const absUser = document.getElementById('abs-user').innerText;
  const absUserCal = document.getElementById('abs-user-cal');
  const squatUser = document.getElementById('squat-user').innerText;
  const squatUserCal = document.getElementById('squat-user-cal');
  const pushUpsUser = document.getElementById('push-ups-user').innerText;
  const pushUpsUserCal = document.getElementById('push-ups-user-cal');
  const spineUser = document.getElementById('spine-user').innerText;
  const spineUserCal = document.getElementById('spine-user-cal');
  const totalUserCal = document.getElementById('total-user-cal');
  
  runUserCal.innerHTML = parseInt((runUser / 60 * weightUser * 9 * 1.05), 10)
  absUserCal.innerHTML = parseInt((absUser / 60 * weightUser * 3.5 * 1.05), 10)
  squatUserCal.innerHTML = parseInt((squatUser / 60 * weightUser * 3.5 * 1.05), 10)
  pushUpsUserCal.innerHTML = parseInt((pushUpsUser / 60 * weightUser * 3.5 * 1.05), 10)
  spineUserCal.innerHTML = parseInt((spineUser / 60 * weightUser * 3.5 * 1.05), 10)
  totalUserCal.innerHTML = Number(runUserCal.innerHTML) + Number(absUserCal.innerHTML) + Number(squatUserCal.innerHTML) + Number(pushUpsUserCal.innerHTML) + Number(spineUserCal.innerHTML)
}
window.addEventListener('load', user_show)