document.querySelectorAll('.btn-toggle').forEach(btn => {
    btn.addEventListener('click', () => {
        const view = btn.dataset.view;
        document.cookie = `home_view=${view};path=/;max-age=${60 * 60 * 24 * 365}`;
        location.reload();
    });
});

// highlight active
const currentView = document.cookie
    .split('; ')
    .find(x => x.startsWith('home_view='))
    ?.split('=')[1] || 'default';

document.querySelectorAll('.btn-toggle').forEach(btn => {
    if (btn.dataset.view === currentView) {
        btn.classList.add('active');
    }
});