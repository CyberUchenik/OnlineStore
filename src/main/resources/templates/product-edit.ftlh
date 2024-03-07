<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Редактирование товара</h1>
    <hr>
    <form action="/product/edit" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="productName">Название товара</label>
            <input type="text" required class="form-control" id="productName" name="title" value="${product.title}">
        </div>
        <div class="form-group">
            <label for="price">Цена товара</label>
            <input type="number" required class="form-control" id="price" name="price" value="${product.price}">
        </div>
        <div class="form-group">
            <label for="description">Описание товара</label>
            <textarea required class="form-control" id="description" name="description">${product.description}</textarea>
        </div>
        <div class="form-group">
            <label for="searchCity">Город</label>
            <select id="searchCity" required name="city" class="form-control">
                <option value="">Выберите город</option>
                <option value="Астана" <#if product.city == "Астана">selected</#if>>Астана</option>
                <option value="Оскемен" <#if product.city == "Оскемен">selected</#if>>Оскемен</option>
                <option value="Актобе" <#if product.city == "Актобе">selected</#if>>Актобе</option>
                <!-- Добавьте другие города по необходимости -->
            </select>
        </div>
        <div class="form-group">
            <label>Текущие изображения:</label>
            <#list product.images as image>
                <img src="/images/${image.id}" height="100" alt="Изображение товара">
            </#list>
        </div>
        <div class="form-group">
            <label>Добавить новые изображения:</label>
            <input type="file" name="file1" id="file1">
            <input type="file" name="file2" id="file2">
            <input type="file" name="file3" id="file3">
        </div>
        <input type="hidden" name="id" value="${product.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" style="width: 100%" class="btn btn-dark">Сохранить изменения</button>
    </form>
</@t.template>
