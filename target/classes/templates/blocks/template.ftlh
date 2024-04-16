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

        <title>BUYSELL</title>
    </head>
    <body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <a href="/">
                <span class="navbar-brand mb-0 h1">BUYSELL</span>
            </a>
            <button class="btn btn-light mx-2" type="button" data-toggle="modal" data-target="#aboutUsModal">
                О нас
            </button>
            <#if user.email??>
                <div class="dropdown text-end">
                    <a href="/profile">
                        <#if user.avatar?? && user.avatar.id??>
                            <img src="/images/${user.avatar.id}" alt="User Avatar"
                                 width="32" height="32" class="rounded-circle">
                        <#else>
                            <img src="/static/images/avatar.png" alt="User Avatar"
                                 width="32" height="32" class="rounded-circle">
                        </#if>
                    </a>
                </div>
            <#else>
                <button class="btn btn-light my-2 my-sm-0" type="button"
                        onclick="window.location.href = '/login'">
                    Войти
                </button>
            </#if>
        </div>
    </nav>

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
