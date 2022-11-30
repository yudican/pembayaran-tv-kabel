<div class="page-inner">
    <div class="row">
        <div class="col-md-12">
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">

                    @foreach ($banners as $key => $banner)
                    <li data-target="#carouselExampleIndicators" data-slide-to="{{$key}}" class="@if ($key == 0) active @endif"></li>
                    @endforeach
                </ol>
                <div class="carousel-inner">
                    @foreach ($banners as $key => $banner)
                    <div class="carousel-item @if ($key == 0) active @endif">
                        <img class="d-block w-100" src="{{asset('storage/'.$banner->image)}}" style="height: 20%;object-fit:cover;" alt="{{$banner->title}}">
                    </div>
                    @endforeach
                </div>
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
</div>