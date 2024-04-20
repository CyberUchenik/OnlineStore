<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Поиск товаров</h1><hr>
    <form method="get" action="/">
        <div class="form-row">
            <div class="form-group col-md-2">
                <label for="searchCity">Город</label>
                <select id="searchCity" name="searchCity" class="form-control">
                    <option value="">Город не выбран</option>
                    <option value="Астана">Астана</option>
                    <option value="Оскемен">Оскемен</option>
                    <option value="Актобе">Актобе</option>
                </select>
            </div>
            <div class="form-group">
                <label for="catalog">Каталог</label>
                <select id="catalog" name="catalog" class="form-control">
                    <option value="">Все категории</option>
                    <option value="Электроника">Электроника</option>
                    <option value="Для дома">Для дома</option>
                    <option value="Одежда">Одежда</option>

                    <!-- Добавьте другие категории по необходимости -->
                    <option value="Услуги">Услуги</option>
                    <option value="Строительство и ремонт">Строительство и ремонт</option>
                    <option value="Аренда и прокат товаров">Аренда и прокат товаров</option>
                    <option value="Недвижимость">Недвижимость</option>
                    <option value="Работа">Работа</option>
                    <option value="Мода и стиль">Мода и стиль</option>
                    <option value="Детский мир">Детский мир</option>
                    <option value="Хобби, отдых и спорт">Хобби, отдых и спорт</option>
                    <option value="Транспорт">Транспорт</option>
                    <option value="Животные">Животные</option>
                    <option value="Отдам даром">Отдам даром</option>
                    <option value="Велосипеды">Велосипеды</option>
                    <option value="Электроинструменты">Электроинструменты</option>
                    <option value="Микрокредит онлайн">Микрокредит онлайн</option>
                    <option value="Мебель">Мебель</option>
                    <option value="Охота и рыбалка">Охота и рыбалка</option>
                    <option value="Онлайн заем от KMF">Онлайн заем от KMF</option>
                    <option value="Телефоны и аксессуары">Телефоны и аксессуары</option>
                </select>

            </div>
            <div class="form-group col-md-10">
                <label for="searchWord">Поиск по объявлениям</label>
                <input type="text" name="searchWord" <#if searchWord??>value="${searchWord}"</#if> class="form-control"
                       id="searchWord">
            </div>
            <button style="width: 100%" type="submit" class="btn btn-dark">Поиск</button>
        </div>
    </form>
    <hr>
    <div class="card-columns">
        <#if products?size == 0>
            <h2 style="text-align: center">По вашему запросу ничего не найдено</h2>
        <#else>
            <#list products as product>
                <a href="/product/${product.id}" class="product-link">
                    <div class="card text-white bg-dark my-3 product">
                        <img src="/images/${product.previewImageId}" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">${product.title}</h5>
                            <p class="card-text">${product.price} ₸</p>
                            <#if user.favoriteProducts?seq_contains(product)>
                                <a href="/favorites/remove/${product.id}" class="btn btn-warning">Удалить из избранного</a>
                            <#else>
                                <a href="/favorites/add/${product.id}" class="btn btn-success">Добавить в избранное</a>
                            </#if>
                        </div>
                        <div class="card-footer">
                            ${product.city}
                        </div>
                    </div>
                </a>
            </#list>
        </#if>
    </div>
</@t.template>