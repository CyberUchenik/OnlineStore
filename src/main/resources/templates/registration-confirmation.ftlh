<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="alert alert-success" role="alert">
        <h4 class="alert-heading">Почти готово!</h4>
        <p>На вашу электронную почту было отправлено письмо с активационным кодом. Пожалуйста, проверьте вашу почту и перейдите по ссылке в письме для завершения регистрации.</p>
        <hr>
        <p class="mb-0">Если вы не получили письмо, проверьте папку "Спам" или <a href="/registration">попробуйте зарегистрироваться заново</a>.</p>
    </div>
</@t.template>
