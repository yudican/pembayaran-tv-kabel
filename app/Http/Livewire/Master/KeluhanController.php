<?php

namespace App\Http\Livewire\Master;

use App\Models\Keluhan;
use Illuminate\Support\Facades\Storage;
use Livewire\Component;
use Livewire\WithFileUploads;

class KeluhanController extends Component
{
    use WithFileUploads;
    public $keluhan_id;
    public $pelanggan;
    public $user_id;
    public $judul_keluhan;
    public $isi_keluhan;
    public $gambar;
    public $gambar_path;


    public $route_name = null;

    public $form_active = false;
    public $form = true;
    public $update_mode = false;
    public $modal = false;

    protected $listeners = ['getDataKeluhanById', 'getKeluhanId'];

    public function mount()
    {
        $this->route_name = request()->route()->getName();
    }

    public function render()
    {
        return view('livewire.master.keluhan')->layout(config('crud-generator.layout'));
    }

    public function store()
    {
        $this->_validate();
        $gambar = $this->gambar_path->store('upload', 'public');
        $data = [
            'user_id'  => auth()->user()->id,
            'judul_keluhan'  => $this->judul_keluhan,
            'isi_keluhan'  => $this->isi_keluhan,
            'gambar'  => $gambar
        ];

        Keluhan::create($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Disimpan']);
    }

    public function update()
    {
        $this->_validate();

        $data = [
            'judul_keluhan'  => $this->judul_keluhan,
            'isi_keluhan'  => $this->isi_keluhan,
        ];
        $row = Keluhan::find($this->keluhan_id);


        if ($this->gambar_path) {
            $gambar = $this->gambar_path->store('upload', 'public');
            $data = ['gambar' => $gambar];
            if (Storage::exists('public/' . $this->gambar)) {
                Storage::delete('public/' . $this->gambar);
            }
        }

        $row->update($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Diupdate']);
    }

    public function delete()
    {
        Keluhan::find($this->keluhan_id)->delete();

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Dihapus']);
    }

    public function _validate()
    {
        $rule = [
            'judul_keluhan'  => 'required',
            'isi_keluhan'  => 'required'
        ];

        return $this->validate($rule);
    }

    public function getDataKeluhanById($keluhan_id)
    {
        $this->_reset();
        $row = Keluhan::find($keluhan_id);
        $this->keluhan_id = $row->id;
        $this->user_id = $row->user_id;
        $this->pelanggan = $row->user?->name ?? '-';
        $this->judul_keluhan = $row->judul_keluhan;
        $this->isi_keluhan = $row->isi_keluhan;
        $this->gambar = $row->gambar;
        if ($this->form) {
            $this->form_active = true;
            $this->emit('loadForm');
        }
        if ($this->modal) {
            $this->emit('showModal');
        }
        $this->update_mode = true;
    }

    public function getKeluhanId($keluhan_id)
    {
        $row = Keluhan::find($keluhan_id);
        $this->keluhan_id = $row->id;
    }

    public function toggleForm($form)
    {
        $this->_reset();
        $this->form_active = $form;
        $this->emit('loadForm');
    }

    public function showModal()
    {
        $this->_reset();
        $this->emit('showModal');
    }

    public function _reset()
    {
        $this->emit('closeModal');
        $this->emit('refreshTable');
        $this->keluhan_id = null;
        $this->user_id = null;
        $this->pelanggan = null;
        $this->judul_keluhan = null;
        $this->isi_keluhan = null;
        $this->gambar = null;
        $this->gambar_path = null;
        $this->form = true;
        $this->form_active = false;
        $this->update_mode = false;
        $this->modal = false;
    }
}
