<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h2>Установка нового пароля</h2>
    <form action="/reset-password" method="post">
        <input type="hidden" name="token" value="${token}">
        <div class="form-group">
            <label for="password">Новый пароль</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Подтвердите новый пароль</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Сохранить новый пароль</button>
    </form>
</@t.template>