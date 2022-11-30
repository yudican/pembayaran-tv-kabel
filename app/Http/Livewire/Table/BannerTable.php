<?php

namespace App\Http\Livewire\Table;

use App\Models\HideableColumn;
use App\Models\Banner;
use Mediconesystems\LivewireDatatables\BooleanColumn;
use Mediconesystems\LivewireDatatables\Column;
use Yudican\LaravelCrudGenerator\Livewire\Table\LivewireDatatable;

class BannerTable extends LivewireDatatable
{
    protected $listeners = ['refreshTable'];
    public $hideable = 'select';
    public $table_name = 'tbl_banners';

    public function builder()
    {
        return Banner::query();
    }

    public function columns()
    {
        return [
            Column::name('id')->label('No.'),
            Column::name('title')->label('Judul')->searchable(),
            Column::callback(['image'], function ($image) {
                return view('livewire.components.photo', [
                    'image_url' => asset('storage/' . $image),
                ]);
            })->label(__('Gambar')),
            Column::callback('status', function ($status) {
                if ($status == 1) {
                    return '<span class="badge badge-success">Aktif</span>';
                } else {
                    return '<span class="badge badge-danger">Tidak Aktif</span>';
                }
            })->label('Status')->searchable(),

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
        $this->emit('getDataBannerById', $id);
    }

    public function getId($id)
    {
        $this->emit('getBannerId', $id);
        $this->emit('showModalConfirm', 'show');
    }

    public function refreshTable()
    {
        $this->emit('refreshLivewireDatatable');
    }
}
