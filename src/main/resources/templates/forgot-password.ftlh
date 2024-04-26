<#import "blocks/template.ftlh" as t>
<@t.template user!> <!-- Здесь добавлен оператор ! со значением по умолчанию -->
    <h2 style="margin-top: 200px;">Сброс пароля</h2>
    <form action="/forgot-password" method="post">
        <div class="form-group">
            <label for="email">Электронная почта</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Отправить ссылку на сброс пароля</button>
    </form>

</@t.template>
