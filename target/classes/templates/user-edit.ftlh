<#import "blocks/template.ftlh" as t>
<@t.template currentUser>
    <h1 style="text-align: center">Редактирование пользователя ${editableUser.name}</h1>
    <hr>
    <form action="/admin/user/edit" method="post">
        <#list roles as role>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="roles" value="${role}"
                       <#if editableUser.roles?seq_contains(role)>checked</#if>
                       id="role_${role}">
                <label class="form-check-label" for="role_${role}">
                    ${role}
                </label>
            </div>
        </#list>
        <input type="hidden" value="${editableUser.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit" class="btn btn-dark">Сохранить изменения</button>
    </form>
</@t.template>
