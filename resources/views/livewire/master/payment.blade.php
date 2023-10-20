<div class="page-inner">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title text-capitalize">
                        <a href="{{route('dashboard')}}">
                            <span><i class="fas fa-arrow-left mr-3"></i>payments</span>
                        </a>
                        <div class="pull-right">
                            @if ($form_active)
                            <button class="btn btn-danger btn-sm" wire:click="toggleForm(false)"><i class="fas fa-times"></i> Cancel</button>
                            @else
                            @if (auth()->user()->hasTeamPermission($curteam, $route_name.':create'))
                            <button class="btn btn-primary btn-sm" wire:click="{{$modal ? 'showModal' : 'toggleForm(true)'}}"><i class="fas fa-plus"></i> Add
                                New</button>
                            @endif
                            @endif
                        </div>
                    </h4>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            @if ($form_active)
            <div class="card">
                <div class="card-body">

                    @if (auth()->user()->role->role_type == 'admin')
                    <x-text-field type="text" name="pelanggan" label="Nama Pelanggan" readonly />
                    @endif
                    <x-select name="priode" label="Priode Pembayaran">
                        <option value="">Select Priode Pembayaran</option>
                        <option value="Januari">Januari</option>
                        <option value="Februari">Februari</option>
                        <option value="Maret">Maret</option>
                        <option value="April">April</option>
                        <option value="Mei">Mei</option>
                        <option value="Juni">Juni</option>
                        <option value="Juli">Juli</option>
                        <option value="Agustus">Agustus</option>
                        <option value="September">September</option>
                        <option value="Oktober">Oktober</option>
                        <option value="November">November</option>
                        <option value="Desember">Desember</option>
                    </x-select>
                    <x-select name="payment_amount" label="Jumlah Pembayaran">
                        <option value="">Select Jumlah Pembayaran</option>
                        
                          <option value="40000">40K</option>
                       
                    </x-select>
                    <x-input-photo foto="{{$payment_image}}" path="{{optional($payment_image_path)->temporaryUrl()}}" name="payment_image_path" label="Bukti Pembayaran" />
                    <x-select name="payment_method" label="Metode Pembayaran">
                        <option value="">Select Metode Pembayaran</option>
                        @foreach ($payments as $item)
                        <option value="{{$item->id}}">{{$item->nama_bank_pembayaran}} - {{$item->nomor_rekening}} ({{$item->nama_rekening}})</option>
                        @endforeach
                    </x-select>
                    @if (auth()->user()->role->role_type == 'admin')
                    <x-select name="payment_status" label="Status Pembayaran">
                        <option value="">Select Status Pembayaran</option>
                        <option value="1">Diterima</option>
                        <option value="2">Ditolak</option>
                    </x-select>
                    @endif

                    <div class="form-group">
                        <button class="btn btn-primary pull-right" wire:click="{{$update_mode ? 'update' : 'store'}}">Simpan</button>
                    </div>
                </div>
            </div>
            @else
            <livewire:table.payment-table params="{{$route_name}}" />
            @endif

        </div>

        {{-- Modal confirm --}}
        <div id="confirm-modal" wire:ignore.self class="modal fade" tabindex="-1" permission="dialog" aria-labelledby="my-modal-title" aria-hidden="true">
            <div class="modal-dialog" permission="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="my-modal-title">Konfirmasi Hapus</h5>
                    </div>
                    <div class="modal-body">
                        <p>Apakah anda yakin hapus data ini.?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" wire:click='delete' class="btn btn-danger btn-sm"><i class="fa fa-check pr-2"></i>Ya, Hapus</button>
                        <button class="btn btn-primary btn-sm" wire:click='_reset'><i class="fa fa-times pr-2"></i>Batal</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @push('scripts')



    <script>
        document.addEventListener('livewire:load', function(e) {
            window.livewire.on('loadForm', (data) => {
                
                
            });

            window.livewire.on('closeModal', (data) => {
                $('#confirm-modal').modal('hide')
            });

            window.livewire.on('showModalConfirm', (data) => {
                $('#confirm-modal').modal(data)
            });
        })
    </script>
    @endpush
</div>
