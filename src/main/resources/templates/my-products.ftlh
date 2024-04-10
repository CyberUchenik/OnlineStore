    <#import "blocks/template.ftlh" as t>
    <@t.template user>
        <h1 style="text-align: center">Мои товары</h1>
        <hr>
        <a class="btn btn-dark mt-3 mb-3" style="text-align: center; width: 100%"
           data-toggle="collapse" href="#collapseExample" role="button"
           aria-expanded="true" aria-controls="collapseExample">
            Добавить новый товар
        </a>
        <div class="collapse mb-3" id="collapseExample" style="">
            <form action="/product/create" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="productName">Название товара</label>
                    <input type="text" required class="form-control"
                           id="productName" name="title">
                </div>
                <div class="form-group">
                    <label for="price">Цена товара</label>
                    <div class="input-group mb-3">
                        <input type="number" required class="form-control" id="price" name="price">
                        <div class="input-group-append">
                            <span class="input-group-text"> ₸</span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="searchCity">Город</label>
                    <select id="searchCity" required name="city" class="form-control">
                        <option value="">Город не выбран</option>

                        <option value="Астана">Астана</option>
                        <option value="Оскемен">Оскемен</option>
                        <option value="Актобе">Актобе</option>

<<<<<<< HEAD
                    </select>
=======
                </select>
            </div>
            <div class="form-group">
                <label for="catalog">Каталог</label>
                <select id="catalog" name="catalog" class="form-control" required>
                    <option value="">Выберите каталог</option>
                    <option value="Электроника">Электроника</option>
                    <option value="Для дома">Для дома</option>
                    <option value="Одежда">Одежда</option>
                    //TODO нужно добавить остальные каталоги
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
            <div class="form-group">
                <label for="description">Описание товара</label>
                <textarea required class="form-control" id="description" name="description"></textarea>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input required type="file" name="file1" id="file1">
                    <label class="custom-file-label" for="file1">Первая фотография к товару</label>
>>>>>>> a91969f967a174362f9e966d398285aa6a2dedf0
                </div>
                <div class="form-group">
                    <label for="description">Описание товара</label>
                    <textarea required class="form-control" id="description" name="description"></textarea>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input required type="file" name="file1" id="file1">
                        <label class="custom-file-label" for="file1">Первая фотография к товару</label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file2" id="file2">
                        <label class="custom-file-label" for="file2">Вторая фотография к товару</label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file3" id="file3">
                        <label class="custom-file-label" for="file3">Третья фотография к товару</label>
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                <button type="submit" style="width: 100%" class="btn btn-dark">Добавить</button>
            </form>
        </div>
        <div class="card-columns">
            <#list products as product>
                <a href="/product/${product.id}" class="product-link">
                    <div class="card text-white bg-dark my-3 product">
                        <div class="card-top">
                            <form action="/product/delete/${product.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-danger m-3">
                                    Удалить
                                </button>
                            </form>
                            <a href="/product/edit/${product.id}" class="btn btn-primary m-3">Изменить</a>
                        </div>
                        <img src="/images/${product.previewImageId}"
                             class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">${product.title}</h5>
                            <p class="card-text">${product.price} ₽</p>
                        </div>
                        <div class="card-footer">
                            ${product.city}
                        </div>
                    </div>
                </a>
            <#else>
                <h1 style="text-align: center">Не найдено</h1>
            </#list>
        </div>
    </@t.template>