<?php

namespace App\Http\Livewire\Doc;

use App\Models\Panduan;
use Illuminate\Support\Facades\Storage;
use Livewire\Component;
use Livewire\WithFileUploads;

class PanduanController extends Component
{
    use WithFileUploads;
    public $panduan_id;
    public $judul_panduan;
    public $isi_panduan;
    public $gambar;
    public $gambar_path;


    public $route_name = null;

    public $form_active = false;
    public $form = true;
    public $update_mode = false;
    public $modal = false;

    protected $listeners = ['getDataPanduanById', 'getPanduanId'];

    public function mount()
    {
        $this->route_name = request()->route()->getName();
    }

    public function render()
    {
        return view('livewire.doc.panduan')->layout(config('crud-generator.layout'));
    }

    public function store()
    {
        $this->_validate();
        $gambar = $this->gambar_path->store('upload', 'public');
        $data = [
            'judul_panduan'  => $this->judul_panduan,
            'isi_panduan'  => $this->isi_panduan,
            'gambar'  => $gambar
        ];

        Panduan::create($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Disimpan']);
    }

    public function update()
    {
        $this->_validate();

        $data = [
            'judul_panduan'  => $this->judul_panduan,
            'isi_panduan'  => $this->isi_panduan,
            'gambar'  => $this->gambar
        ];
        $row = Panduan::find($this->panduan_id);


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
        Panduan::find($this->panduan_id)->delete();

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Dihapus']);
    }

    public function _validate()
    {
        $rule = [
            'judul_panduan'  => 'required',
            'isi_panduan'  => 'required'
        ];

        return $this->validate($rule);
    }

    public function getDataPanduanById($panduan_id)
    {
        $this->_reset();
        $row = Panduan::find($panduan_id);
        $this->panduan_id = $row->id;
        $this->judul_panduan = $row->judul_panduan;
        $this->isi_panduan = $row->isi_panduan;
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

    public function getPanduanId($panduan_id)
    {
        $row = Panduan::find($panduan_id);
        $this->panduan_id = $row->id;
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
        $this->panduan_id = null;
        $this->judul_panduan = null;
        $this->isi_panduan = null;
        $this->gambar = null;
        $this->gambar_path = null;
        $this->form = true;
        $this->form_active = false;
        $this->update_mode = false;
        $this->modal = false;
    }
}
