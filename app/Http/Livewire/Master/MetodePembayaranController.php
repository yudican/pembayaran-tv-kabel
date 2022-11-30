<?php

namespace App\Http\Livewire\Master;

use App\Models\MetodePembayaran;
use Livewire\Component;


class MetodePembayaranController extends Component
{
    
    public $metode_pembayaran_id;
    public $nama_bank_pembayaran;
public $nama_rekening;
public $nomor_rekening;
    
   

    public $route_name = null;

    public $form_active = false;
    public $form = false;
    public $update_mode = false;
    public $modal = true;

    protected $listeners = ['getDataMetodePembayaranById', 'getMetodePembayaranId'];

    public function mount()
    {
        $this->route_name = request()->route()->getName();
    }

    public function render()
    {
        return view('livewire.master.metode-pembayaran')->layout(config('crud-generator.layout'));
    }

    public function store()
    {
        $this->_validate();
        
        $data = ['nama_bank_pembayaran'  => $this->nama_bank_pembayaran,
'nama_rekening'  => $this->nama_rekening,
'nomor_rekening'  => $this->nomor_rekening];

        MetodePembayaran::create($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Disimpan']);
    }

    public function update()
    {
        $this->_validate();

        $data = ['nama_bank_pembayaran'  => $this->nama_bank_pembayaran,
'nama_rekening'  => $this->nama_rekening,
'nomor_rekening'  => $this->nomor_rekening];
        $row = MetodePembayaran::find($this->metode_pembayaran_id);

        

        $row->update($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Diupdate']);
    }

    public function delete()
    {
        MetodePembayaran::find($this->metode_pembayaran_id)->delete();

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Dihapus']);
    }

    public function _validate()
    {
        $rule = [
            'nama_bank_pembayaran'  => 'required',
'nama_rekening'  => 'required',
'nomor_rekening'  => 'required'
        ];

        return $this->validate($rule);
    }

    public function getDataMetodePembayaranById($metode_pembayaran_id)
    {
        $this->_reset();
        $row = MetodePembayaran::find($metode_pembayaran_id);
        $this->metode_pembayaran_id = $row->id;
        $this->nama_bank_pembayaran = $row->nama_bank_pembayaran;
$this->nama_rekening = $row->nama_rekening;
$this->nomor_rekening = $row->nomor_rekening;
        if ($this->form) {
            $this->form_active = true;
            $this->emit('loadForm');
        }
        if ($this->modal) {
            $this->emit('showModal');
        }
        $this->update_mode = true;
    }

    public function getMetodePembayaranId($metode_pembayaran_id)
    {
        $row = MetodePembayaran::find($metode_pembayaran_id);
        $this->metode_pembayaran_id = $row->id;
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
        $this->metode_pembayaran_id = null;
        $this->nama_bank_pembayaran = null;
$this->nama_rekening = null;
$this->nomor_rekening = null;
        $this->form = false;
        $this->form_active = false;
        $this->update_mode = false;
        $this->modal = true;
    }
}
