<#import "blocks/template.ftlh" as t>
<@t.template user!>
    <div class="alert alert-success" role="alert">
        <h4 class="alert-heading">Активация прошла успешно!</h4>
        <p>Ваш аккаунт был успешно активирован. Теперь вы можете войти в систему, используя вашу электронную почту и пароль.</p>
        <hr>
        <p class="mb-0"><a href="/login" class="alert-link">Перейти на страницу входа</a></p>
    </div>
</@t.template>
