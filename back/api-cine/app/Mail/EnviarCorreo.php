<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Mail;
use App\Mail\EnviarCorreo;
use App\Entrada; // Asegúrate de importar el modelo Entrada si no lo has hecho
use App\Sesion; // Asegúrate de importar el modelo Sesion si no lo has hecho
use App\User; // Asegúrate de importar el modelo User si no lo has hecho
use App\Pelicula; // Asegúrate de importar el modelo Pelicula si no lo has hecho

class EnviarCorreo extends Mailable
{
    use Queueable, SerializesModels;
    public $entrada;
    public $sesion;
    public $usuario;
    public $pelicula;


    /**
     * Create a new message instance.
     */
    public function __construct($entrada, $sesion, $usuario, $pelicula)
    {
        $this->entrada = $entrada;
        $this->sesion = $sesion;
        $this->usuario = $usuario;
        $this->pelicula = $pelicula;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Entrada de Cine',
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'mail.hello',
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}
