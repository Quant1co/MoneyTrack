import Rails from "@rails/ujs";
Rails.start();

document.getElementById('phone').addEventListener('input', function(e) {
    let value = e.target.value.replace(/\D/g, '');
    if (value.length > 0) {
        value = '8' + value.slice(1); // Всегда начинается с 8
    }
    e.target.value = value.length > 10 
      ? `8(${value.slice(1, 4)})${value.slice(4, 7)}-${value.slice(7, 11)}` 
      : value;
});

document.addEventListener('DOMContentLoaded', () => {
    const phoneInput = document.getElementById('phone');

    phoneInput.addEventListener('input', function (e) {
        // Удаляем все нецифровые символы
        let value = e.target.value.replace(/\D/g, '');

        // Если номер начинается с 8 и содержит минимум 10 цифр
        if (value.startsWith('8') && value.length >= 11) {
            // Форматируем в 8(XXX)XXX-XXXX
            value = `8(${value.slice(1, 4)})${value.slice(4, 7)}-${value.slice(7, 11)}`;
        }

        // Устанавливаем отформатированное значение обратно в поле
        e.target.value = value;
    });
});

