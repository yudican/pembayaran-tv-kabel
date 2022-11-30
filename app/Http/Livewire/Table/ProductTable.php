<?php

namespace App\Http\Livewire\Table;

use App\Models\HideableColumn;
use App\Models\Product;
use Mediconesystems\LivewireDatatables\BooleanColumn;
use Mediconesystems\LivewireDatatables\Column;
use Yudican\LaravelCrudGenerator\Livewire\Table\LivewireDatatable;

class ProductTable extends LivewireDatatable
{
    protected $listeners = ['refreshTable'];
    public $hideable = 'select';
    public $table_name = 'tbl_products';

    public function builder()
    {
        return Product::query();
    }

    public function columns()
    {
        return [
            Column::name('id')->label('No.'),
            Column::name('harga_product')->label('Harga Produk')->searchable(),
            Column::name('kecepatan')->label('Kecepatan Koneksi')->searchable(),
            Column::name('nama_product')->label('Nama Produk')->searchable(),

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
        $this->emit('getDataProductById', $id);
    }

    public function getId($id)
    {
        $this->emit('getProductId', $id);
        $this->emit('showModalConfirm', 'show');
    }

    public function refreshTable()
    {
        $this->emit('refreshLivewireDatatable');
    }
}
