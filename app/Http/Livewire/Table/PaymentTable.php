<?php

namespace App\Http\Livewire\Table;

use App\Models\MetodePembayaran;
use App\Models\Payment;
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
        $user = auth()->user();
        if ($user->role->role_type == 'member') {
            return Payment::query()->where('user_id', $user->id);
        }

        return Payment::query();
    }

    public function columns()
    {
        return [
            Column::name('id')->label('No.'),
            Column::name('user.name')->label('Pelanggan')->searchable(),
            Column::name('payment_amount')->label('Jumlah Pembayaran')->searchable(),
            Column::name('priode')->label('Priode Pembayaran')->searchable(),
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
