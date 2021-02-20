function icon() {
  const userIcon = document.getElementById('user-icon');
  const userIconEdit = document.getElementById('user-icon-edit');
  
  userIcon.addEventListener('click', () => {
    userIconEdit.classList.toggle('open-user-icon-edit');
  });
}
window.addEventListener('load', icon)