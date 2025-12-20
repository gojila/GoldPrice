let appToastInstance = null;

function showToast(type, message) {
    const toastEl = document.getElementById('appToast');
    const toastBody = document.getElementById('toastMessage');

    toastEl.classList.remove('text-bg-success', 'text-bg-danger');

    toastEl.classList.add(type === 'success' ? 'text-bg-success' : 'text-bg-danger');
    toastBody.textContent = message;

    if (appToastInstance) appToastInstance.dispose();
    appToastInstance = new bootstrap.Toast(toastEl, { delay: 2500, autohide: true });

    toastEl.offsetHeight; // force reflow
    appToastInstance.show();
}