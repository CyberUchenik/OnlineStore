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