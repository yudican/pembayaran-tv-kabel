<?php

namespace App\Http\Livewire\Master;

use App\Models\Product;
use Livewire\Component;


class ProductController extends Component
{
    
    public $product_id;
    public $harga_product;
public $kecepatan;
public $nama_product;
    
   

    public $route_name = null;

    public $form_active = false;
    public $form = true;
    public $update_mode = false;
    public $modal = false;

    protected $listeners = ['getDataProductById', 'getProductId'];

    public function mount()
    {
        $this->route_name = request()->route()->getName();
    }

    public function render()
    {
        return view('livewire.master.product')->layout(config('crud-generator.layout'));
    }

    public function store()
    {
        $this->_validate();
        
        $data = ['harga_product'  => $this->harga_product,
'kecepatan'  => $this->kecepatan,
'nama_product'  => $this->nama_product];

        Product::create($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Disimpan']);
    }

    public function update()
    {
        $this->_validate();

        $data = ['harga_product'  => $this->harga_product,
'kecepatan'  => $this->kecepatan,
'nama_product'  => $this->nama_product];
        $row = Product::find($this->product_id);

        

        $row->update($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Diupdate']);
    }

    public function delete()
    {
        Product::find($this->product_id)->delete();

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Dihapus']);
    }

    public function _validate()
    {
        $rule = [
            'harga_product'  => 'required',
'kecepatan'  => 'required',
'nama_product'  => 'required'
        ];

        return $this->validate($rule);
    }

    public function getDataProductById($product_id)
    {
        $this->_reset();
        $row = Product::find($product_id);
        $this->product_id = $row->id;
        $this->harga_product = $row->harga_product;
$this->kecepatan = $row->kecepatan;
$this->nama_product = $row->nama_product;
        if ($this->form) {
            $this->form_active = true;
            $this->emit('loadForm');
        }
        if ($this->modal) {
            $this->emit('showModal');
        }
        $this->update_mode = true;
    }

    public function getProductId($product_id)
    {
        $row = Product::find($product_id);
        $this->product_id = $row->id;
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
        $this->product_id = null;
        $this->harga_product = null;
$this->kecepatan = null;
$this->nama_product = null;
        $this->form = true;
        $this->form_active = false;
        $this->update_mode = false;
        $this->modal = false;
    }
}
