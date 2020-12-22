const notification = document.querySelectorAll(".notification-btn")
notification.forEach((notify) => {
    notify.addEventListener('click', () => {
        document.getElementById("check").checked = false
    })
})