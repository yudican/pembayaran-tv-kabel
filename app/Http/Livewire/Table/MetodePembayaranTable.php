<?php

namespace App\Http\Livewire\Table;

use App\Models\HideableColumn;
use App\Models\MetodePembayaran;
use Mediconesystems\LivewireDatatables\BooleanColumn;
use Mediconesystems\LivewireDatatables\Column;
use Yudican\LaravelCrudGenerator\Livewire\Table\LivewireDatatable;

class MetodePembayaranTable extends LivewireDatatable
{
    protected $listeners = ['refreshTable'];
    public $hideable = 'select';
    public $table_name = 'tbl_metode_pembayarans';

    public function builder()
    {
        return MetodePembayaran::query();
    }

    public function columns()
    {
        return [
            Column::name('id')->label('No.'),
Column::name('nama_bank_pembayaran')->label('Nama Bank Pembayaran')->searchable(),
Column::name('nama_rekening')->label('Nama Rekening')->searchable(),
Column::name('nomor_rekening')->label('Nomor Rekening')->searchable(),

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
                                        'route' => 'confirmDelete(' . $id . ')',
                                        'label' => 'Hapus',
                                    ]
                                ]
                ]);
            })->label(__('Aksi')),
        ];
    }

    public function getDataById($id)
    {
        $this->emit('getDataMetodePembayaranById', $id);
    }

    public function getId($id)
    {
        $this->emit('getMetodePembayaranId', $id);
    }

    public function refreshTable()
    {
        $this->emit('refreshLivewireDatatable');
    }
}
