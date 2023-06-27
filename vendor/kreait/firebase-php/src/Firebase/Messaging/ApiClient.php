<?php

declare(strict_types=1);

namespace Kreait\Firebase\Messaging;

use GuzzleHttp\ClientInterface;
use GuzzleHttp\Promise\PromiseInterface;
use Kreait\Firebase\Exception\FirebaseException;
use Kreait\Firebase\Exception\MessagingApiExceptionConverter;
use Kreait\Firebase\Exception\MessagingException;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;
use Throwable;

/**
 * @internal
 */
class ApiClient
{
    public function __construct(
        private readonly ClientInterface $client,
        private readonly MessagingApiExceptionConverter $errorHandler,
    ) {
    }

    /**
     * @param array<string, mixed> $options
     *
     * @throws FirebaseException
     * @throws MessagingException
     */
    public function send(RequestInterface $request, array $options = []): ResponseInterface
    {
        try {
            return $this->client->send($request, $options);
        } catch (Throwable $e) {
            throw $this->errorHandler->convertException($e);
        }
    }

    /**
     * @param array<string, mixed> $options
     */
    public function sendAsync(RequestInterface $request, array $options = []): PromiseInterface
    {
        return $this->client->sendAsync($request, $options)
            ->then(null, function (Throwable $e): never {
                throw $this->errorHandler->convertException($e);
            })
        ;
    }
}
