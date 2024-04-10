<#import "blocks/template.ftlh" as t>
<@t.template user!{}> <!-- Используйте пустой объект как значение по умолчанию -->
    <div class="alert alert-success">
        <h4 class="alert-heading">Проверьте вашу электронную почту</h4>
        <p>Если адрес электронной почты существует в нашей системе, на него была отправлена ссылка для сброса пароля.</p>
    </div>
</@t.template>
