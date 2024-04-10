<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Регистрация</h1>
    <hr>
    <form action="/registration" method="post" id="registrationForm">
        <div class="form-group">
            <label for="name">Имя пользователя</label>
            <input type="text" class="form-control" placeholder="Ваше имя" required id="name" name="name">
        </div>
        <div class="form-group">
            <label for="email">Электронная почта</label>
            <input type="email" class="form-control" placeholder="example@mail.com" id="email" required name="email">
        </div>
        <div class="form-group">
            <label for="phoneNumber">Номер телефона</label>
            <input type="text" class="form-control" placeholder="+77004446699" id="phoneNumber" required name="phoneNumber" pattern="^\+[1-9]\d{1,14}$">
        </div>
        <div class="form-group">
            <label for="password">Пароль</label>
            <input type="password" class="form-control" placeholder="Не менее 8 символов, включая цифры" id="password" required name="password" pattern="(?=.*\d)[A-Za-z\d]{8,}">
        </div>
        <div class="form-group">
            <label for="confirmPassword">Повторите пароль</label>
            <input type="password" class="form-control" placeholder="Повторите ваш пароль" id="confirmPassword" required name="confirmPassword">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" style="width: 100%" class="btn btn-dark">Зарегистрироваться</button>
    </form>
    <#if errorMessage??>
        <h2 style="color: red">${errorMessage}</h2>
    </#if>
    <script>
        document.getElementById('registrationForm').addEventListener('submit', function(event) {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            if (password !== confirmPassword) {
                event.preventDefault(); // Останавливаем отправку формы
                alert('Пароли не совпадают!');
            }
        });
    </script>
</@t.template>
