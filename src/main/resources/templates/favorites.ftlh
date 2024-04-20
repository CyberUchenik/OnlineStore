<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Избранные товары</h1>
    <#if favorites?size == 0>
        <h2 style="text-align: center">Избранные товары отсутствуют</h2>
    <#else>
        <div class="container">
            <div class="row">
                <#-- Итерация по списку избранных товаров -->
                <#list favorites as favorite>
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm">
                            <div class="card-body">
                                <p class="card-text">${favorite.title}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <#-- Кнопка для просмотра деталей товара -->
                                        <a href="/product/${favorite.id}" class="btn btn-sm btn-outline-secondary">View</a>
                                        <#-- Кнопка для удаления из избранных -->
                                        <a href="/favorites/remove/${favorite.id}" class="btn btn-sm btn-danger">Удалить</a>
                                    </div>
                                    <small class="text-muted">${favorite.price} ₸</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
    </#if>
</@t.template>