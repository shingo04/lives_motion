function motion() {
  const weight = document.getElementById('weight').innerText;
  const run = document.getElementById('run');
  const runCal = document.getElementById('run-cal');
  const abs = document.getElementById('abs')
  const absCal = document.getElementById('abs-cal')
  const squat = document.getElementById('squat');
  const squatCal = document.getElementById('squat-cal');
  const pushUps = document.getElementById('push-ups')
  const pushUpsCal = document.getElementById('push-ups-cal')
  const spine = document.getElementById('spine');
  const spineCal = document.getElementById('spine-cal');
  const totalCal = document.getElementById('total-cal')

  run.addEventListener('input', () => {
    const runValue = run.value;
    runCal.innerHTML = parseInt((runValue / 60 * weight * 9 * 1.05), 10)
    totalCal.innerHTML = Number(runCal.innerHTML) + Number(absCal.innerHTML) + Number(squatCal.innerHTML) + Number(pushUpsCal.innerHTML) + Number(spineCal.innerHTML)
  });

  abs.addEventListener('input', () => {
    const absValue = abs.value;
    absCal.innerHTML = parseInt((absValue / 60 * weight * 3.5 * 1.05), 10)
    totalCal.innerHTML = Number(runCal.innerHTML) + Number(absCal.innerHTML) + Number(squatCal.innerHTML) + Number(pushUpsCal.innerHTML) + Number(spineCal.innerHTML)
  });

  squat.addEventListener('input', () => {
    const squatValue = squat.value;
    squatCal.innerHTML = parseInt((squatValue / 60 * weight * 3.5 * 1.05), 10)
    totalCal.innerHTML = Number(runCal.innerHTML) + Number(absCal.innerHTML) + Number(squatCal.innerHTML) + Number(pushUpsCal.innerHTML) + Number(spineCal.innerHTML)
  });

  pushUps.addEventListener('input', () => {
    const pushUpsValue = pushUps.value;
    pushUpsCal.innerHTML = parseInt((pushUpsValue / 60 * weight * 3.5 * 1.05), 10)
    totalCal.innerHTML = Number(runCal.innerHTML) + Number(absCal.innerHTML) + Number(squatCal.innerHTML) + Number(pushUpsCal.innerHTML) + Number(spineCal.innerHTML)
  });

  spine.addEventListener('input', () => {
    const spineValue = spine.value;
    spineCal.innerHTML = parseInt((spineValue / 60 * weight * 3.5 * 1.05), 10)
    totalCal.innerHTML = Number(runCal.innerHTML) + Number(absCal.innerHTML) + Number(squatCal.innerHTML) + Number(pushUpsCal.innerHTML) + Number(spineCal.innerHTML)
  });
}
window.addEventListener('load', motion)