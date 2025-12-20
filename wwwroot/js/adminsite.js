let appToastInstance = null;

function showToast(type, message) {
    const toastEl = document.getElementById('appToast');
    const toastBody = document.getElementById('toastMessage');

    // Reset class
    toastEl.classList.remove(
        'text-bg-success',
        'text-bg-danger',
        'show',
        'hide'
    );

    // Gán màu theo type
    if (type === 'success') {
        toastEl.classList.add('text-bg-success');
    } else {
        toastEl.classList.add('text-bg-danger');
    }

    toastBody.textContent = message;

    // Nếu đã tồn tại toast instance thì dispose
    if (appToastInstance) {
        appToastInstance.dispose();
    }

    // Tạo instance mới
    appToastInstance = new bootstrap.Toast(toastEl, {
        delay: 3000,
        autohide: true
    });

    // Force reflow để Bootstrap nhận trạng thái mới
    toastEl.offsetHeight;

    appToastInstance.show();
}