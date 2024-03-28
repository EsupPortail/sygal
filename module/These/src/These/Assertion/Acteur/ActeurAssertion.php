<?php

namespace These\Assertion\Acteur;

use Application\Assertion\AbstractAssertion;
use Application\Assertion\Exception\FailedAssertionException;
use Application\Assertion\ThrowsFailedAssertionExceptionTrait;
use Application\RouteMatch;
use Application\Service\UserContextServiceAwareInterface;
use Laminas\Permissions\Acl\Resource\ResourceInterface;
use These\Entity\Db\Acteur;
use These\Entity\Db\These;
use These\Provider\Privilege\ActeurPrivileges;
use These\Service\Acteur\ActeurServiceAwareTrait;
use These\Service\These\TheseServiceAwareTrait;
use UnicaenApp\Service\MessageCollectorAwareInterface;

class ActeurAssertion extends AbstractAssertion
    implements UserContextServiceAwareInterface, MessageCollectorAwareInterface
{
    use ThrowsFailedAssertionExceptionTrait;
    use TheseServiceAwareTrait;
    use ActeurServiceAwareTrait;

    private Acteur $acteur;
    private These $these;

    /**
     * @param array $page
     * @return bool
     */
    public function __invoke(array $page): bool
    {
        return $this->assertPage($page);
    }

    /**
     * @param array $page
     * @return bool
     */
    private function assertPage(array $page): bool
    {
        $this->these = $this->getRequestedThese();
        if ($this->these === null) {
            return true;
        }

        try {
            $this->theseService->assertAppartenanceThese($this->acteur->getThese(), $this->userContextService);
        } catch (FailedAssertionException $e) {
            if ($e->getMessage()) {
                $this->getServiceMessageCollector()->addMessage($e->getMessage(), __CLASS__);
            }
            return false;
        }

        return true;
    }

    /**
     * @param string $controller
     * @param string $action
     * @param string $privilege
     * @return boolean
     */
    protected function assertController($controller, $action = null, $privilege = null): bool
    {
        if (! parent::assertController($controller, $action, $privilege)) {
            return false;
        }

        $this->acteur = $this->getRequestedActeur();

        try {
            switch ($action) {
                case 'modifier':
                    $this->assertEtatThese($this->acteur->getThese());
                    $this->theseService->assertAppartenanceThese($this->acteur->getThese(), $this->userContextService);
                    break;
            }

        } catch (FailedAssertionException $e) {
            if ($e->getMessage()) {
                $this->getServiceMessageCollector()->addMessage($e->getMessage(), __CLASS__);
            }
            return false;
        }

        return true;
    }

    /**
     * @param Acteur $entity
     * @param string $privilege
     * @return boolean
     */
    protected function assertEntity(ResourceInterface $entity, $privilege = null): bool
    {
        if (! parent::assertEntity($entity, $privilege)) {
            return false;
        }

        $this->acteur = $entity;

        try {

            switch ($privilege) {
                case ActeurPrivileges::MODIFIER_ACTEUR_SES_THESES:
                    $this->assertEtatThese($this->acteur->getThese());
                    $this->theseService->assertAppartenanceThese($this->acteur->getThese(), $this->userContextService);
            }

        } catch (FailedAssertionException $e) {
            if ($e->getMessage()) {
                $this->getServiceMessageCollector()->addMessage($e->getMessage(), __CLASS__);
            }
            return false;
        }

        return true;
    }

    private function assertEtatThese(These $these): void
    {
        $this->assertTrue($these->getEtatThese() == These::ETAT_EN_COURS, "La thèse doit être en cours");
    }

    private function getRequestedThese(): ?These
    {
        if ($acteur = $this->getRequestedActeur()) {
            return $acteur->getThese();
        } elseif ($routeMatch = $this->getRouteMatch()) {
            return $routeMatch->getThese();
        } else {
            return null;
        }
    }

    private function getRequestedActeur(): ?Acteur
    {
        if ($id = $this?->getRouteMatch()?->getParam('acteur')) {
            return $this->acteurService->getRepository()->find($id);
        }

        return null;
    }

    protected function getRouteMatch(): ?RouteMatch
    {
        /** @var \Application\RouteMatch $rm */
        $rm = $this->getMvcEvent()->getRouteMatch();
        return $rm;
    }
}