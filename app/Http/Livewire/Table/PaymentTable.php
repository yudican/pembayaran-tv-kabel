<?php

namespace App\Http\Livewire\Table;

use App\Models\HideableColumn;
use App\Models\MetodePembayaran;
use App\Models\Payment;
use Mediconesystems\LivewireDatatables\BooleanColumn;
use Mediconesystems\LivewireDatatables\Column;
use Yudican\LaravelCrudGenerator\Livewire\Table\LivewireDatatable;

use function PHPUnit\Framework\callback;

class PaymentTable extends LivewireDatatable
{
    protected $listeners = ['refreshTable'];
    public $hideable = 'select';
    public $table_name = 'tbl_payments';

    public function builder()
    {
        return Payment::query();
    }

    public function columns()
    {
        return [
            Column::name('id')->label('No.'),
            Column::name('payment_amount')->label('Jumlah Pembayaran')->searchable(),
            Column::name('payment_date')->label('Tanggal Pembayaran')->searchable(),
            Column::callback(['payment_image'], function ($image) {
                return view('livewire.components.photo', [
                    'image_url' => asset('storage/' . $image),
                ]);
            })->label(__('Bukti Pembayaran')),
            Column::callback('payment_method', function ($payment_method) {
                $payment = MetodePembayaran::where('id', $payment_method)->first();
                return $payment->nama_bank_pembayaran . ' - ' . $payment->nomor_rekening . '(' . $payment->nama_rekening . ')';
            })->label('Metode Pembayaran')->searchable(),
            Column::callback('payment_status', function ($status) {
                if ($status == 1) {
                    return '<span class="badge badge-success">Lunas</span>';
                } else if ($status == 2) {
                    return '<span class="badge badge-danger">Ditolak</span>';
                }
                return '<span class="badge badge-warning">Menunggu Konfirmasi</span>';
            })->label('Status Pembayaran')->searchable(),
            Column::name('product.nama_product')->label('Pilihan Produk')->searchable(),
            Column::name('user_id')->label('Pelanggan')->searchable(),

            Column::callback(['id'], function ($id) {
                return view('crud-generator-components::action-button', [
                    'id' => $id,
                    'actions' => [
                        [
                            'type' => 'button',
                            'route' => 'getDataById(' . $id . ')',
                            'label' => 'Edit',
                        ],
                        [
                            'type' => 'button',
                            'route' => 'getId(' . $id . ')',
                            'label' => 'Hapus',
                        ]
                    ]
                ]);
            })->label(__('Aksi')),
        ];
    }

    public function getDataById($id)
    {
        $this->emit('getDataPaymentById', $id);
    }

    public function getId($id)
    {
        $this->emit('getPaymentId', $id);
        $this->emit('showModalConfirm', 'show');
    }

    public function refreshTable()
    {
        $this->emit('refreshLivewireDatatable');
    }
}
