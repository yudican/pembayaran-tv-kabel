<?php

namespace App\Http\Livewire\Master;

use App\Models\Banner;
use Illuminate\Support\Facades\Storage;
use Livewire\Component;
use Livewire\WithFileUploads;

class BannerController extends Component
{
    use WithFileUploads;
    public $banner_id;
    public $image;
    public $status;
    public $title;
    public $image_path;


    public $route_name = null;

    public $form_active = false;
    public $form = true;
    public $update_mode = false;
    public $modal = false;

    protected $listeners = ['getDataBannerById', 'getBannerId'];

    public function mount()
    {
        $this->route_name = request()->route()->getName();
    }

    public function render()
    {
        return view('livewire.master.banner')->layout(config('crud-generator.layout'));
    }

    public function store()
    {
        $this->_validate();
        $image = $this->image_path->store('upload', 'public');
        $data = [
            'image'  => $image,
            'status'  => $this->status,
            'title'  => $this->title
        ];

        Banner::create($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Disimpan']);
    }

    public function update()
    {
        $this->_validate();

        $data = [
            'status'  => $this->status,
            'title'  => $this->title
        ];
        $row = Banner::find($this->banner_id);


        if ($this->image_path) {
            $image = $this->image_path->store('upload', 'public');
            $data = ['image' => $image];
            if (Storage::exists('public/' . $this->image)) {
                Storage::delete('public/' . $this->image);
            }
        }

        $row->update($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Diupdate']);
    }

    public function delete()
    {
        Banner::find($this->banner_id)->delete();

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Dihapus']);
    }

    public function _validate()
    {
        $rule = [
            'status'  => 'required',
            'title'  => 'required'
        ];

        return $this->validate($rule);
    }

    public function getDataBannerById($banner_id)
    {
        $this->_reset();
        $row = Banner::find($banner_id);
        $this->banner_id = $row->id;
        $this->image = $row->image;
        $this->status = $row->status;
        $this->title = $row->title;
        if ($this->form) {
            $this->form_active = true;
            $this->emit('loadForm');
        }
        if ($this->modal) {
            $this->emit('showModal');
        }
        $this->update_mode = true;
    }

    public function getBannerId($banner_id)
    {
        $row = Banner::find($banner_id);
        $this->banner_id = $row->id;
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
        $this->banner_id = null;
        $this->image_path = null;
        $this->image = null;
        $this->status = null;
        $this->title = null;
        $this->form = true;
        $this->form_active = false;
        $this->update_mode = false;
        $this->modal = false;
    }
}
