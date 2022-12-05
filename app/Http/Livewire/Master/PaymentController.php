<?php

namespace App\Http\Livewire\Master;

use App\Models\MetodePembayaran;
use App\Models\Payment;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Livewire\Component;
use Livewire\WithFileUploads;

class PaymentController extends Component
{
    use WithFileUploads;
    public $payment_id;
    public $payment_amount;
    public $priode;
    public $payment_image;
    public $payment_method;
    public $payment_status;
    public $product_id;
    public $user_id;
    public $payment_image_path;
    public $pelanggan;


    public $route_name = null;

    public $form_active = false;
    public $form = true;
    public $update_mode = false;
    public $modal = false;

    protected $listeners = ['getDataPaymentById', 'getPaymentId'];

    public function mount()
    {
        $this->route_name = request()->route()->getName();
    }

    public function render()
    {
        return view('livewire.master.payment', [
            'payments' => MetodePembayaran::all(),
        ])->layout(config('crud-generator.layout'));
    }

    public function store()
    {
        $this->_validate();
        $payment_image = $this->payment_image_path->store('upload', 'public');
        $data = [
            'payment_amount'  => $this->payment_amount,
            'priode'  => $this->priode,
            'payment_image'  => $payment_image,
            'payment_method'  => $this->payment_method,
            'payment_status'  => $this->payment_status ?? 0,
            'user_id'  => Auth::user()->id
        ];

        Payment::create($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Disimpan']);
    }

    public function update()
    {
        $this->_validate();

        $data = [
            'payment_amount'  => $this->payment_amount,
            'priode'  => $this->priode,
            'payment_method'  => $this->payment_method,
            'payment_status'  => $this->payment_status,
        ];
        $row = Payment::find($this->payment_id);


        if ($this->payment_image_path) {
            $payment_image = $this->payment_image_path->store('upload', 'public');
            $data = ['payment_image' => $payment_image];
            if (Storage::exists('public/' . $this->payment_image)) {
                Storage::delete('public/' . $this->payment_image);
            }
        }

        $row->update($data);

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Diupdate']);
    }

    public function delete()
    {
        Payment::find($this->payment_id)->delete();

        $this->_reset();
        return $this->emit('showAlert', ['msg' => 'Data Berhasil Dihapus']);
    }

    public function _validate()
    {
        $rule = [
            'payment_amount'  => 'required',
            'priode'  => 'required',
            'payment_method'  => 'required',
        ];

        return $this->validate($rule);
    }

    public function getDataPaymentById($payment_id)
    {
        $this->_reset();
        $row = Payment::find($payment_id);
        $this->payment_id = $row->id;
        $this->payment_amount = $row->payment_amount;
        $this->priode = $row->priode;
        $this->payment_image = $row->payment_image;
        $this->payment_method = $row->payment_method;
        $this->payment_status = $row->payment_status;
        $this->user_id = $row->user_id;
        $this->pelanggan = $row->user?->name;
        if ($this->form) {
            $this->form_active = true;
            $this->emit('loadForm');
        }
        if ($this->modal) {
            $this->emit('showModal');
        }
        $this->update_mode = true;
    }

    public function getPaymentId($payment_id)
    {
        $row = Payment::find($payment_id);
        $this->payment_id = $row->id;
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
        $this->payment_id = null;
        $this->payment_amount = null;
        $this->priode = null;
        $this->payment_image_path = null;
        $this->payment_image = null;
        $this->payment_method = null;
        $this->payment_status = null;
        $this->user_id = null;
        $this->form = true;
        $this->form_active = false;
        $this->update_mode = false;
        $this->modal = false;
    }
}
