<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="alert alert-danger">
        <h4 class="alert-heading">Ошибка</h4>
        <p>Токен для сброса пароля недействителен или истек его срок. Пожалуйста, попробуйте запросить сброс пароля еще раз.</p>
    </div>
</@t.template>
