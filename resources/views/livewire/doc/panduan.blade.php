<div class="page-inner">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title text-capitalize">
                        <a href="{{route('dashboard')}}">
                            <span><i class="fas fa-arrow-left mr-3"></i>panduan</span>
                        </a>

                    </h4>
                </div>
            </div>
        </div>

        @if (in_array(auth()->user()->role->role_type,['admin','superadmin']))
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <embed type="application/pdf" src="{{asset('assets/panduan-admin.pdf')}}" style="width:100%;height:1000px;"></embed>
                </div>
            </div>
        </div>
        @else
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <embed type="application/pdf" src="{{asset('assets/panduan.pdf')}}" style="width:100%;height:1000px;"></embed>
                </div>
            </div>
        </div>
        @endif

    </div>
</div>