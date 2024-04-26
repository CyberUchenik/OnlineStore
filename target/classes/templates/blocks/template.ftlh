<#macro template user>
    <!doctype html>
    <html lang="ru">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="/static/css/style.css">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
              integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
              crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">

        <title>BUYSELL</title>
        <style>
            .logo {
                font-size: 1.5em; /* Увеличивает размер шрифта */
                font-weight: bold; /* Делает шрифт жирным */
                color: #8ad790; /* Меняет цвет текста на черный */
            }

            .custom-btn-size {
                font-size: 1.00rem; /* Увеличение размера шрифта, например, до 1.25rem */
            }
            .button-container {
                display: flex; /* Использование flexbox для выравнивания элементов */
                align-items: center; /* Центрирование элементов по вертикали */
                justify-content: flex-end; /* Выравнивание элементов по правому краю */
            }
            /* Увеличенный отступ между элементами */
            .button-container > a,
            .button-container > button {
                margin-left: 20px; /* Увеличение отступа слева до 20px */
            }
        </style>
    </head>
    <body>
    <header class="p-3 bg-dark text-white fixed-top">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-between">
                <!-- Логотип и ссылки в одном flex-контейнере -->
                <div class="d-flex align-items-center">
                    <a href="/" class="me-3 custom-btn-size" style="font-weight: 900; font-size: 24px;">
                        <span style="color: white; font-weight: 900;">Buy</span><span style="color: #229808; font-weight: 900;">Sell</span>
                    </a>
                    <nav class="navbar navbar-expand-lg">
                        <div class="navbar-nav">
                            <a class="nav-link active text-white custom-btn-size" aria-current="page" href="#" data-toggle="modal" data-target="#aboutUsModal">О нас</a>
                            <a class="nav-link text-white custom-btn-size" href="/favorites">Избранные</a>
                        </div>
                    </nav>
                </div>
                <!-- Измененный контейнер для кнопок с измененным порядком элементов -->
                <div class="button-container">
                    <!-- Ссылка WhatsApp перемещена перед условным оператором аватара -->
                    <a href="https://wa.me/87786881238" class="btn custom-btn-size" style="background-color: #229808; color: white;" target="_blank">
                        <i class="bi bi-whatsapp"></i>
                    </a>

                    <#if user.email??>
                        <a href="/profile" class="dropdown">
                            <#if user.avatar?? && user.avatar.id??>
                                <img src="/images/${user.avatar.id}" alt="User Avatar"
                                     width="32" height="32" class="rounded-circle">
                            <#else>
                                <img src="/static/images/avatar.png" alt="User Avatar"
                                     width="32" height="32" class="rounded-circle">
                            </#if>
                        </a>
                    <#else>
                        <button type="button" class="btn btn-outline-light custom-btn-size" onclick="window.location.href = '/login'">
                            <i class="bi bi-door-open"></i> Войти
                        </button>
                    </#if>
                </div>
            </div>
        </div>
    </header>
    <!-- About Us Modal -->
    <div class="modal fade" id="aboutUsModal" tabindex="-1" role="dialog" aria-labelledby="aboutUsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="aboutUsModalLabel">О нас</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h6>Наша команда:</h6>
                    <ul>
                        <li>Капаев Тасполат - Team Lead</li>
                        <li>Кошенов Азамат - Backend</li>
                        <li>Жапалов Альхан - Frontend</li>
                        <li>Құсайнов Нурал - Frontend</li>
                    </ul>
                    <p>Фотографии команды:</p>
                    <div class="row">
                        <div class="col-md-6">
                            <img src="/static/images/TaspoJavist.jpeg" class="img-fluid" alt="Member 1">
                        </div>
                        <div class="col-md-6">
                            <img src="/static/images/AzaBackend.jpeg" class="img-fluid" alt="Member 2">
                        </div>
                        <div class="col-md-6">
                            <img src="/static/images/AlkhanFrontend.jpeg" class="img-fluid" alt="Member 3">
                        </div>
                        <div class="col-md-6">
                            <img src="/static/images/NuralFrontend.jpeg" class="img-fluid" alt="Member 4">
                        </div>
                    </div>
                    <p>Адрес нашего офиса:</p>
                    <p>Казахстан, Астана, ул. Петрова 10</p>
                    <div class="mapouter">
                        <div class="gmap_canvas">
                            <iframe width="100%" height="300" id="gmap_canvas"
                                    src="https://maps.google.com/maps?q=Kazakhstan%2C%20Astana%2C%20Petrova%2010&t=&z=13&ie=UTF8&iwloc=&output=embed"
                                    frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container mt-4">
        <#nested/>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
            integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
            crossorigin="anonymous"></script>
    </body>
    </html>
</#macro>