<?php

namespace App\Http\Livewire\Table;

use App\Models\HideableColumn;
use App\Models\Keluhan;
use Mediconesystems\LivewireDatatables\BooleanColumn;
use Mediconesystems\LivewireDatatables\Column;
use Yudican\LaravelCrudGenerator\Livewire\Table\LivewireDatatable;

class KeluhanTable extends LivewireDatatable
{
    protected $listeners = ['refreshTable'];
    public $hideable = 'select';
    public $table_name = 'tbl_keluhans';

    public function builder()
    {
        $user = auth()->user();
        if ($user->role->role_type == 'member') {
            return Keluhan::query()->where('user_id', $user->id);
        }
        return Keluhan::query();
    }

    public function columns()
    {
        return [
            Column::name('id')->label('No.'),
            Column::name('user.name')->label('Pelanggan')->searchable(),
            Column::name('judul_keluhan')->label('Judul Keluhan')->searchable(),
            Column::name('isi_keluhan')->label('Isi Keluhan')->searchable(),
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
        $this->emit('getDataKeluhanById', $id);
    }

    public function getId($id)
    {
        $this->emit('getKeluhanId', $id);
    }

    public function refreshTable()
    {
        $this->emit('refreshLivewireDatatable');
    }
}
