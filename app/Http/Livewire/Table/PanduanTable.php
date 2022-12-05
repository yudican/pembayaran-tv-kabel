<?php

namespace App\Http\Livewire\Table;

use App\Models\Panduan;
use Mediconesystems\LivewireDatatables\Column;
use Yudican\LaravelCrudGenerator\Livewire\Table\LivewireDatatable;

class PanduanTable extends LivewireDatatable
{
    protected $listeners = ['refreshTable'];
    public $hideable = 'select';
    public $table_name = 'tbl_panduans';

    public function builder()
    {
        return Panduan::query();
    }

    public function columns()
    {
        return [
            Column::name('id')->label('No.'),
            Column::name('judul_panduan')->label('Judul Panduan')->searchable(),
            Column::name('isi_panduan')->label('Isi Panduan')->searchable(),
            Column::callback(['gambar'], function ($image) {
                return view('livewire.components.photo', [
                    'image_url' => asset('storage/' . $image),
                ]);
            })->label(__('Gambar')),

            Column::callback(['id'], function ($id) {
                return view('crud-generator-components::action-button', [
                    'id' => $id,
                    'actions' => [
                        [
                            'type' => 'button',
                            'route' => 'getDataById(' . $id . ')',
                            'label' => 'Edit',
                        ],
                        // [
                        //     'type' => 'button',
                        //     'route' => 'confirmDelete(' . $id . ')',
                        //     'label' => 'Hapus',
                        // ]
                    ]
                ]);
            })->label(__('Aksi')),
        ];
    }

    public function getDataById($id)
    {
        $this->emit('getDataPanduanById', $id);
    }

    public function getId($id)
    {
        $this->emit('getPanduanId', $id);
    }

    public function refreshTable()
    {
        $this->emit('refreshLivewireDatatable');
    }
}
