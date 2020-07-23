<?php

namespace Application\Assertion\RapportAnnuel;

use Application\Assertion\Interfaces\PageAssertionInterface;
use Application\Entity\Db\These;
use Application\Service\AuthorizeServiceAwareTrait;
use Application\Service\UserContextServiceAwareTrait;

class RapportAnnuelPageAssertion implements PageAssertionInterface
{
    use AuthorizeServiceAwareTrait;
    use UserContextServiceAwareTrait;
    
    /**
     * @var These
     */
    private $these;

    /**
     * @param array $context
     */
    public function setContext(array $context)
    {
        $this->these = $context['these'];
    }

    /**
     * @param array $page
     * @return bool
     */
    public function assert(array $page)
    {
        return $this->these->getEtatThese() === These::ETAT_EN_COURS;
    }

}