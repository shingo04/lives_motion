function index() {
  const btn = document.querySelector('.btn-menu');
  const nav = document.querySelector('nav');
  const descriptions = document.getElementById('descriptions');
  const howToUse = document.getElementById('how-to-use');
  const use = document.getElementById('use');
  const description = document.getElementById('description');
  const how = document.getElementById('how');
  const howTo = document.getElementById('how-to');

  use.addEventListener('click', () => {
    description.classList.toggle('open-menu')
    if (howTo.classList.toggle('open-menu')) {
      howTo.classList.toggle('open-menu')
    }
  });

  descriptions.addEventListener('mouseover', () => {
    descriptions.setAttribute("style", "background-color:skyblue;")
  });

  descriptions.addEventListener('mouseout', () => {
    descriptions.removeAttribute("style")
  });

  howToUse.addEventListener('mouseover', () => {
    howToUse.setAttribute("style", "background-color:skyblue;")
  });

  howToUse.addEventListener('mouseout', () => {
    howToUse.removeAttribute("style")
  });

  how.addEventListener('click', () => {
    howTo.classList.toggle('open-menu')
    if (description.classList.toggle('open-menu')) {
      description.classList.toggle('open-menu')
    }
  });

  btn.addEventListener('click', () => {
    nav.classList.toggle('open-menu')
    if (btn.innerHTML === 'メニュー') {
      btn.innerHTML = '閉じる';
    } else {
      btn.innerHTML = 'メニュー';
    }
  });
}
window.addEventListener('load', index)