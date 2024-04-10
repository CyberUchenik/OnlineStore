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
            <input type="number" required class="form-control" id="price" name="price" value="${price}">
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
            </select>
        </div>
        <div class="form-group">
            <label for="catalog">Каталог</label>
            <select id="catalog" name="catalog" class="form-control" required>
                <option value="">Выберите каталог</option>
                <option value="Электроника" <#if product.catalog == "Электроника">selected</#if>>Электроника</option>
                <option value="Для дома" <#if product.catalog == "Для дома">selected</#if>>Для дома</option>
                <option value="Одежда" <#if product.catalog == "Одежда">selected</#if>>Одежда</option>
                <option value="Услуги" <#if product.catalog == "Услуги">selected</#if>>Услуги</option>
                <option value="Строительство и ремонт" <#if product.catalog == "Строительство и ремонт">selected</#if>>Строительство и ремонт</option>
                <option value="Аренда и прокат товаров" <#if product.catalog == "Аренда и прокат товаров">selected</#if>>Аренда и прокат товаров</option>
                <option value="Недвижимость" <#if product.catalog == "Недвижимость">selected</#if>>Недвижимость</option>
                <option value="Работа" <#if product.catalog == "Работа">selected</#if>>Работа</option>
                <option value="Мода и стиль" <#if product.catalog == "Мода и стиль">selected</#if>>Мода и стиль</option>
                <option value="Детский мир" <#if product.catalog == "Детский мир">selected</#if>>Детский мир</option>
                <option value="Хобби, отдых и спорт" <#if product.catalog == "Хобби, отдых и спорт">selected</#if>>Хобби, отдых и спорт</option>
                <option value="Транспорт" <#if product.catalog == "Транспорт">selected</#if>>Транспорт</option>
                <option value="Животные" <#if product.catalog == "Животные">selected</#if>>Животные</option>
                <option value="Отдам даром" <#if product.catalog == "Отдам даром">selected</#if>>Отдам даром</option>
                <option value="Велосипеды" <#if product.catalog == "Велосипеды">selected</#if>>Велосипеды</option>
                <option value="Электроинструменты" <#if product.catalog == "Электроинструменты">selected</#if>>Электроинструменты</option>
                <option value="Микрокредит онлайн" <#if product.catalog == "Микрокредит онлайн">selected</#if>>Микрокредит онлайн</option>
                <option value="Мебель" <#if product.catalog == "Мебель">selected</#if>>Мебель</option>
                <option value="Охота и рыбалка" <#if product.catalog == "Охота и рыбалка">selected</#if>>Охота и рыбалка</option>
                <option value="Онлайн заем от KMF" <#if product.catalog == "Онлайн заем от KMF">selected</#if>>Онлайн заем от KMF</option>
                <option value="Телефоны и аксессуары" <#if product.catalog == "Телефоны и аксессуары">selected</#if>>Телефоны и аксессуары</option>
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
