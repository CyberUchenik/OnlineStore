<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Edit Profile</h1>
    <hr>
    <div style="text-align: center">
        <form action="/update-profile" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="text" class="form-control" placeholder="Ваше имя" id="name" name="name" value="${user.name}" required>
            <br><br>
            <input type="text" class="form-control" placeholder="+77004446699" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required pattern="^\+[1-9]\d{1,14}$">
            <br><br>
            <button type="submit" class="btn btn-success">Save Changes</button>
        </form>
        <br>
        <a href="/profile" class="btn btn-danger">Cancel</a>
    </div>
</@t.template>